class GistNinja < Sinatra::Application
  require './gist_ninja/github_client'

  get '/' do
    'GistNinja!'
  end

  post '/' do
    request.body.rewind
    gist_body = request.body.read
    gist = GithubClient.new_anonymous_gist(gist_body)
    if gist
      [200, gist.html_url]
    else
      [500, 'Nope.']
    end
  end

  post '/!' do
    request.body.rewind
    gist_body = request.body.read
    gist = GithubClient.new_anonymous_gist(gist_body, public: true)
    if gist
      [200, gist.html_url]
    else
      [500, 'Nope.']
    end
  end
end
