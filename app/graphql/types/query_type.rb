Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root of the schema.'

  field :zoo do
    type Types::ZooType
    argument :id, !types.ID
    description 'Get a Zoo by ID'
    resolve ->(_obj, args, _ctx) { Zoo.find(args['id']) }
  end

  field :viewer do
    type Types::UserType
    resolve ->(_obj, _args, ctx) { ctx[:current_user] }
  end
end
