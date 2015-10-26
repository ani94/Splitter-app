class MailWorker
  include Sneakers::Worker
  # This worker will connect to "dashboard.posts" queue
  # env is set to nil since by default the actuall queue name would be
  # "dashboard.posts_development"
  from_queue "email.email", env: nil

  # work method receives message payload in raw format
  # in our case it is JSON encoded string
  # which we can pass to RecentPosts service without
  # changes
  def work(raw_post)
    email_params = JSON.parse(raw_post).with_indifferent_access
    send_simple_message(params)
    ack! # we need to let queue know that message was received
  end

  def send_simple_message(params)
    RestClient.post "https://api:key-de9d6d592b16daae97d59287c7d60d7f"\
    "@api.mailgun.net/v3/sandbox4fe8201931a1436a8e92ab7db3719bf6.mailgun.org/messages",
    :from => "no-reply@splitter.com",
    :to => params[:to_email],
    :subject => params[:subject],
    :text => params[:body]
  end
end
