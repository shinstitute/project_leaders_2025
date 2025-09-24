require 'csv'

module Jekyll
  class ProfilePagesGenerator < Generator
    safe true
    priority :high

    def generate(site)
      return unless site.data['profiles']
      
      # If profiles data is a CSV file, parse it
      if site.data['profiles'].is_a?(String)
        csv_content = site.data['profiles']
        profiles = CSV.parse(csv_content, headers: true, header_converters: :symbol)
      else
        profiles = site.data['profiles']
      end

      profiles.each do |profile|
        # Skip if name is empty
        next if profile[:name].nil? || profile[:name].strip.empty?

        # Create a slug from the name
        slug = Jekyll::Utils.slugify(profile[:name])
        
        # Create the profile page
        site.pages << ProfilePage.new(site, site.source, "profiles/#{slug}", profile.to_h)
      end
    end
  end

  class ProfilePage < Page
    def initialize(site, base, dir, profile_data)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'profile.html')
      
      # Set page data from CSV row
      profile_data.each do |key, value|
        self.data[key.to_s] = value
      end
      
      # Set layout and title
      self.data['layout'] = 'profile'
      self.data['title'] = profile_data[:name] || profile_data['name']
      
      # Set permalink
      self.data['permalink'] = "/profiles/#{Jekyll::Utils.slugify(profile_data[:name] || profile_data['name'])}/"
    end
  end
end