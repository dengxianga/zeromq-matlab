-- Pubsub envelope publisher
--https://github.com/booksbyus/zguide/blob/master/examples/Lua/psenvpub.lua
require "zhelpers"
local zmq = require "lzmq"

-- Prepare our context and publisher
local context = zmq.context()
local publisher, err = context:socket{zmq.PUB, bind = "tcp://*:5561"}
zassert(publisher, err)

while true do
  -- Write two messages, each with an envelope and content
  publisher:sendx("A", "We don't want to see this")
  publisher:sendx("B", "We would like to see this")
  sleep (1);
end

--  We never get here but clean up anyhow
publisher:close()
context:term()