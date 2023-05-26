# frozen_string_literal: true

# Модуль группирующий настройки и бизнес операции, связанные с получением данных о погоде
module Operation

  mattr_accessor :weather_reader

  def self.setup
    yield self
  end
end
