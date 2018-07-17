module AttrEncryptedKms
  module Model
    extend ActiveSupport::Concern

    # The premise is that we intercept calls to the special 'kms_dek' method on the model,
    # giving it the plaintext Data Encryption Key (DEK). If the 'kms_dek' column is not present
    # for the record, we first create one via the Amazon Key Management System (KMS) API, storing the
    # ciphertext in the DB and returning the plaintext. If it is present, we call out to Amazon KMS
    # asking them to decrypt the DEK, and return the result. Results of decryption are memoized so this
    # network overhead should only be incurred at most one time per model instance per request (warning:
    # if a model is reloaded, it will result in the unmemoized version being called again since we memoize
    # via an instance method).

    def kms_dek
      @decrypted_kms_dek ||= decrypt_kms_dek
    end

    private

    def decrypt_kms_dek
      kms = Aws::KMS::Client.new

      extant_dek = encrypted_kms_dek
      if extant_dek.blank?
        resp = kms.generate_data_key(key_id: ENV['KMS_ATTR_ENCRYPTED_KEK_ID'], key_spec: 'AES_256')

        # Save the encrypted DEK, and do it directly to the DB in case we're in a transaction or
        # there are presence validators on the record.
        encoded_encrypted_dek = Base64.strict_encode64(resp.ciphertext_blob)
        if persisted?
          # rubocop:disable Rails/SkipsModelValidations
          update_column(:encrypted_kms_dek, encoded_encrypted_dek)
          # rubocop:enable Rails/SkipsModelValidations
        else
          self.encrypted_kms_dek = encoded_encrypted_dek
        end

        return resp.plaintext
      end

      # Ask KMS to decrypt the extant DEK.
      kms.decrypt(ciphertext_blob: Base64.strict_decode64(extant_dek)).plaintext
    end
  end
end
