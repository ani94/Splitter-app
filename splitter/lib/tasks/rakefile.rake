namespace :rabbitmq do
  desc "Setup routing"
  task :setup do
    require "bunny"

    conn = Bunny.new
    conn.start

    ch = conn.create_channel

    # get or create exchange
    x = ch.fanout("splitter.email")

    # get or create queue (note the durable setting)
    queue = ch.queue("email.email", durable: true)

    # bind queue to exchange
    queue.bind("splitter.email")

    conn.close
  end
end
