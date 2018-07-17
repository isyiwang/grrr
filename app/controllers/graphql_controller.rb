class GraphqlController < ApplicationController
  protect_from_forgery unless: :dev_schema_query?
  skip_before_action :require_login, if: :should_not_require_login?

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      current_user: current_user,
    }
    result = GrrrrSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def dev_schema_query?
    # Exempt login and CSRF checks if it's the introspection query used to
    # generate Flow Types for our GQL queries/types.

    return false unless Rails.env.development? && 'POST' == request.method

    parsed_query = GraphQL.parse(params[:query])

    'IntrospectionQuery' == parsed_query.definitions.first.name &&
      '__schema' == parsed_query.definitions.first.selections.first.name
  end

  def sign_up_mutation?
    parsed_query = GraphQL.parse(params[:query])

    'mutation' == parsed_query.definitions.first.operation_type &&
      'signUp' == parsed_query.definitions.first.selections.first.name
  end

  def should_not_require_login?
    dev_schema_query? || sign_up_mutation?
  end
end
