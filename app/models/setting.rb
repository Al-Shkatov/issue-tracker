class Setting < ActiveRecord::Base
  def self.get(key, scope='global')
    data = self.find_by(key: key, scope: scope)
    return data.value.to_i unless data.nil? 
  end
end
