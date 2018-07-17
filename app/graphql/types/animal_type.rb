Types::AnimalType = GraphQL::ObjectType.define do
  name 'Animal'
  description 'Animals taken from their homes and caged in zoos for human entertainment.'

  field :id, !types.ID
  field :name, !types.String
  field :species, !types.String
  field :gender, !types.String
  field :zoo, !Types::ZooType do
    resolve ->(object, _args, _ctx) { object.zoo }
  end
end
