require 'octokit'

class GistNinja::GithubClient
  DEFAULT_GIST_TITLE = 'gist'
  DEFAULT_GIST_DESCRIPTION = 'gist created from gist.ninja'

  class << self
    def new_anonymous_gist(body, title: DEFAULT_GIST_TITLE, description: DEFAULT_GIST_DESCRIPTION, public: false)
      client    = new_client
      gist_opts = single_file_to_opts(body, title, description, public)
      create_gist_from_opts(client, gist_opts)
    end

    private

    def new_client
      Octokit::Client.new
    end

    def single_file_to_opts(body, title, description, public)
      files = {}
      files[title] = {content: body}

      {
        public: public,
        description: description,
        files: files
      }
    end

    def create_gist_from_opts(client, opts)
      begin
        gist = client.create_gist(opts)
      rescue Octokit::Error => e
        return false
      end

      gist
    end
  end
end
