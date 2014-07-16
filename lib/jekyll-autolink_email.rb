require 'jekyll'
require 'rinku'

module Jekyll
  class AutolinkEmail < Jekyll::Generator

    HTML_ENTITIES = {
      '@' => '&#064;',
      '.' => '&#046;'
    }

    attr_accessor :email_addresses

    safe true

    def initialize(config)
      config['autolink_email'] ||= {}
      self.email_addresses = []
    end

    def generate(site)
      @site = site
      site.pages.each { |page| autolinkify page if page.html?}
      site.posts.each { |page| autolinkify page }
    end

    private

    def autolinkify(page)
      page.content = Rinku.auto_link(page.content, :email_addresses, link_attr, skip_tags) do |email_address|
        if escape?
          email_addresses << email_address.dup
          html_encode(email_address)
        else
          email_address
        end
      end
      url_encode_email_addresses(page.content) if escape?
    end

    def html_encode(email_address)
      HTML_ENTITIES.each do |char, code|
        email_address.gsub!(char, code)
      end
      email_address
    end

    # A hack since Rinku doesn't offer a hook into changing what the link is
    def url_encode_email_addresses(content)
      content.gsub!(/mailto:(#{email_addresses.join('|')})/) do |m|
        m[$1] = ERB::Util.url_encode($1)
        m
      end
    end

    def escape?
      @site.config['autolink_email']['escape']
    end

    def link_attr
      @link_attr ||= @site.config['autolink_email']['link_attr']
    end

    def skip_tags
      @skip_tags ||= Array(@site.config['autolink_email']['skip_tags'])
    end
  end
end
