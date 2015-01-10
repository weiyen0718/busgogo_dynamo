require 'aws-sdk'


class Busgogo < AWS::Record::HashModel
  string_attr :num
  string_attr :station
  string_attr :address
end  

 dynamo_db = AWS::DynamoDB.new()
  
         
    table = dynamo_db.tables.create('Busgogo', 10, 5)

    sleep 1 while table.status == :creating
    table.status #=> :active


  #  def self.up
		# create_table :tutorials do |t|
		# t.integer :num
		# t.text :station
		# t.text :address
  # end


  # def self.destory(id)
  #   find(id).delete
  # end

  # def self.delete_all
  #   all.each { |r| r.delete}
  # end
end