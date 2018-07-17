Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :signUp, !Types::SignUpResultType do
    argument :input, !Types::SignUpInputType
    resolve ->(_obj, args, _ctx) {
      name = args.input.name
      return GraphQL::ExecutionError.new('Please enter your name.') if name.blank?

      email = args.input.email
      return GraphQL::ExecutionError.new('Please enter your email.') if email.blank?

      password = args.input.password
      return GraphQL::ExecutionError.new('Please choose a password.') if password.blank?

      user = User.find_by(email: email)
      if user.present?
        return GraphQL::ExecutionError.new(
          'A user with this email already exists. Try logging in.',
        )
      end

      user = User.create!(
        name: name,
        email: email,
        password: password,
      )
      user.reconfirm!

      OpenStruct.new(confirmation_email_sent: true, user: user)
    }
  end
end
