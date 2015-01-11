##BusGoGo

###Description ( Hsinzhu Bus Website )

We use *Hsinzhu Bus Website* because we often take hsinzhu bus to somewhere.
Everytime we are heading for somewhere, we go to their website(http://www.hcbus.com.tw/) to get information about their service station, time, and route.
Therefore, we think it will be convenience for us to use web scraper to get specific information we want.
This website dosen't provide API and need not log in.
Take the link() to use our service.

### API Usages
There are APIs you can use

+Bus stop address information:

        https://.herokuapp.com/api/v2/station/(num).json

  You have three choices to replace the ```(num)``` part.
  1. use ```1``` to get the all stop name and address in 新竹地區.
  2. use ```2``` to get the all stop name and address in 竹東地區.

  until 10

###Example Code

Usage : ruby executable.rb [number]

1) ruby executable.rb [number] <br/>
2) ruby executable.rb 1 <br/>
    Save HsinZhu Bus Website structure into a file (Structure.txt) <br/>
3) ruby executable.rb 2 <br/>
    Show HsinZhu Bus Station. <br/>
4) ruby executable.rb 3 <br/>
    Get bus stataion information in detail. <br/>
5) ruby executable.rb 4 <br/>
    Get file (bus stataion information)bus(Output.txt).
###Authors

Yen Wei ,Wu ChiaChun

### For Authors


