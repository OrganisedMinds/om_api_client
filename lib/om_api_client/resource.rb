class OM::Api::Resource < Hash
<<<<<<< HEAD
  # Absorb a hash as an OM::Api::Resource
  #
  # @param hash [Hash] A hash to absorb
  # @returns [OM::Api::Resource] (recursed)
  #
=======
>>>>>>> Switch over from Sawyer to Faraday
  def self.absorb(hash)
    res = self.new.merge(hash)

    res.each do |k,v|
      if v.is_a?(Hash)
        res[k] = absorb(v)
      elsif v.is_a?(Array)
        res[k] = v.map { |i| i.is_a?(Hash) ? absorb(i) : i }
      end
    end
  end

  def method_missing(name, *args, &block)
    super
  rescue NoMethodError => e
    name = name.to_s

    raise e unless self.keys.include?(name)

    self[name]
  end
end
