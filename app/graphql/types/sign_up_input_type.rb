Types::SignUpInputType = GraphQL::InputObjectType.define do
  name 'SignUpInput'
  description 'Name, email and password for a user signing up.'

  argument :name, !types.String
  argument :email, !types.String
  argument :password, !types.String
end
