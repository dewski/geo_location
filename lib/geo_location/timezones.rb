module GeoLocation
  
  class << self
    
    def timezone(country, region=nil)
      return nil if GeoLocation::timezones.empty?
      return nil if country.nil? || country.empty?
      zones = GeoLocation::timezones[country.to_sym]
      (zones.is_a?(Hash) && !region.nil? && !region.empty?) ? zones[region.to_sym] : zones
    end
    
    def build_timezones
      if GeoLocation::timezones.empty?
        data = {}
        
        file = File.join(File.dirname(__FILE__), 'timezones.txt')
        File.open(file, "r") do |infile|
          while (line = infile.gets)
            zones = line.split("\n")
            zones.each do |z|
              zone = z.split(',')
              country = zone[0].to_sym
              region = zone[1].empty? ? '' : zone[1].to_sym
              value = zone[2]
              
              data[country] = {} if data[country].nil?
              if region.to_s.empty?
                data[country] = value
              else
                data[country][region] = value
              end
              
            end # end zones.each
          end # end while
        end # end file.open
        
        GeoLocation::timezones = data
      end # end if
    end
    
  end
  
end
