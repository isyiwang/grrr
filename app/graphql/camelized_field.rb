module CamelizedField
  def self.call(target, field_name, *args, &block)
    # Modify the incodming name:
    camelized_field_name = field_name.to_s.camelize(:lower)

    # However, keep the original field_name (underscore/snake cased) as the property keyword arg:
    if args.last.is_a?(Hash)
      keyword_args = args.last
    else
      keyword_args = {}
      args << keyword_args
    end
    keyword_args[:property] = field_name

    # Use the new name to create the GQL field:
    GraphQL::Define::AssignObjectField.call(target, camelized_field_name, *args, &block)
  end
end
