Types::SignUpResultType = GraphQL::ObjectType.define do
  name 'SignUpResult'
  description 'A boolean of whether the confirmation email was sent and the user.'

  field :confirmation_email_sent, !types.Boolean
  field :user, !Types::UserType
end
