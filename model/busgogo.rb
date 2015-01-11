require 'aws-sdk'


class Busgogo < AWS::Record::HashModel
  integer_attr :num
  string_attr :station
  string_attr :address
end  

