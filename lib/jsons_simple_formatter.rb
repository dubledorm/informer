# frozen_string_literal: true

# Форматирование лога
class JSONSimpleFormatter < ActiveSupport::Logger::SimpleFormatter
  def call(severity, time, _, message)
    "#{JSON.generate(type: severity, time: time.iso8601, message:)}\n"
  end
end
