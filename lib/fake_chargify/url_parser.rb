module FakeChargify
  module UrlParser
    def get_id_from_uri(uri)
      match = uri.path.match(/(\/\d.(xml|json)\z)/)
      if !match.nil? && match.size > 0
        match = match[0].match(/\d/)
        return id = match[0].to_i if !match.nil? && match.size > 0
      end
    end
  end
end