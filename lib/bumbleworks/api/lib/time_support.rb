module TimeSupport
  class << self
    def seconds_to_units(seconds, include_zeros: false, round_seconds: true)
      seconds = seconds.to_i if round_seconds
      units = Hash[
        [:days, :hours, :minutes, :seconds].zip(
          [60, 60, 24].inject([seconds]) {|result, unitsize|
            result.unshift(*result.shift.divmod(unitsize))
            result
          }
        )
      ]
      units.reject! { |k,v| v == 0 } unless include_zeros
      units
    end

    def seconds_to_units_in_words(seconds, **options)
      seconds_to_units(seconds, options).map { |unit, num|
        "#{num} #{unit}"
      }.join(', ')
    end
  end
end