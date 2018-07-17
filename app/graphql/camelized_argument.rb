module CamelizedArgument
  def self.call(target, argument_name, *args, &block)
    # Modify the incoming argument name:
    camelized_argument_name = argument_name.to_s.camelize(:lower)
    GraphQL::Define::AssignArgument.call(target, camelized_argument_name, *args, &block)
  end
end
