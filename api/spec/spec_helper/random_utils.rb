module RandomUtils

    def self.random_string(length)
        [*'A'..'Z', *0..9].sample(length).join
    end

    def self.random_integer(length)
        [0..9].sample(length).join
    end

    def self.random_datetime from = 0.0, to = Time.now
        Time.at(from + rand * (to.to_f - from.to_f))
      end

end