# frozen_string_literal: true

# Базовый класс для ответов от функций бизнес операций
class BaseReaderResponse
  ERROR_CODE_VALUES = { error: :error, success: :success }.freeze

  attr_reader :error_code, :message, :result

  def self.success(result_value)
    raise 'Need result_value' unless result_value

    validate!(result_value)

    result = new
    result.instance_variable_set(:@error_code, ERROR_CODE_VALUES[:success])
    result.instance_variable_set(:@result, result_value)
    result
  end

  def self.error(message)
    result = new
    result.instance_variable_set(:@error_code, ERROR_CODE_VALUES[:error])
    result.instance_variable_set(:@message, message)
    result
  end

  def self.validate!(_result_value); end

  def success?
    error_code == :success
  end
end
