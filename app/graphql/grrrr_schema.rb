GrrrrSchema = GraphQL::Schema.define do
  GraphQL::ObjectType.accepts_definitions(camelized_field: CamelizedField)
  GraphQL::InterfaceType.accepts_definitions(camelized_field: CamelizedField)
  # TODO(abe): Figure out best way to do this.
  # GraphQL::Field.accepts_definitions(camelized_argument: CamelizedArgument)
  # GraphQL::InputType.accepts_definitions(
  #   camelized_argument: CamelizedArgument,
  #   camelized_input_field: CamelizedArgument,
  # )

  mutation(Types::MutationType)
  query(Types::QueryType)
end
