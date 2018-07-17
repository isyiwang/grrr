module AttrEncryptedKms
  module Meta
    extend ActiveSupport::Concern

    class_methods do
      def use_attr_encrypted_kms
        include AttrEncryptedKms::Model
      end
    end
  end
end

ActiveRecord::Base.send(:include, AttrEncryptedKms::Meta) if defined?(ActiveRecord)
