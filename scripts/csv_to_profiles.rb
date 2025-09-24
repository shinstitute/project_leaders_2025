#!/usr/bin/env ruby

require 'csv'
require 'yaml'

# Helper script to convert CSV profile data to Jekyll profile pages

def slugify(text)
  text.to_s.downcase.strip.gsub(/[^a-z0-9\s-]/, '').gsub(/\s+/, '-').gsub(/-+/, '-')
end

def csv_to_profiles
  csv_file = '_data/profiles.csv'
  profiles_dir = '_profiles'
  
  unless File.exist?(csv_file)
    puts "Error: #{csv_file} not found!"
    return
  end
  
  # Create profiles directory if it doesn't exist
  Dir.mkdir(profiles_dir) unless Dir.exist?(profiles_dir)
  
  # Read CSV and create profile pages
  CSV.foreach(csv_file, headers: true) do |row|
    name = row['name']
    next if name.nil? || name.strip.empty?
    
    slug = slugify(name)
    filename = "#{profiles_dir}/#{slug}.md"
    
    # Prepare front matter
    front_matter = {
      'layout' => 'profile',
      'name' => row['name'],
      'title' => row['title'],
      'organization' => row['organization'],
      'email' => row['email'],
      'bio' => row['bio'],
      'image' => row['image'],
      'linkedin' => row['linkedin'],
      'github' => row['github'],
      'website' => row['website']
    }
    
    # Remove empty fields
    front_matter.reject! { |k, v| v.nil? || v.strip.empty? }
    
    # Create the profile page content
    content = "---\n"
    content += front_matter.to_yaml.gsub(/^---\n/, '')
    content += "---\n\n"
    content += "## Additional Information\n\n"
    content += "Add additional details about #{name} here using markdown.\n\n"
    content += "### Skills & Expertise\n\n"
    content += "- Add relevant skills\n"
    content += "- Add areas of expertise\n"
    content += "- Add specializations\n\n"
    content += "### Recent Work\n\n"
    content += "Describe recent projects, publications, or achievements.\n"
    
    # Write the file
    File.write(filename, content)
    puts "Created: #{filename}"
  end
  
  puts "\nProfile pages generated successfully!"
  puts "Remember to add profile images to the assets/images/ directory."
end

def csv_to_yaml
  csv_file = '_data/profiles.csv'
  yaml_file = '_data/profiles.yml'
  
  unless File.exist?(csv_file)
    puts "Error: #{csv_file} not found!"
    return
  end
  
  profiles = []
  CSV.foreach(csv_file, headers: true) do |row|
    profile = {}
    row.headers.each do |header|
      value = row[header]
      profile[header] = value if value && !value.strip.empty?
    end
    profiles << profile unless profile.empty?
  end
  
  File.write(yaml_file, profiles.to_yaml)
  puts "Created: #{yaml_file}"
end

# Main execution
if ARGV.include?('--yaml-only')
  csv_to_yaml
else
  csv_to_profiles
  csv_to_yaml
end