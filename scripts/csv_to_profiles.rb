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
  
  # CSV columns: Submission,Status ,First,Last,Email,Institution,Department,Website,Citizenship Status,Academic Status,Title,Abstract ,Academic/Research Interests,Motivation,Additional Comments

  # Read CSV and create profile pages
  CSV.foreach(csv_file, headers: true) do |row|
    name = "#{row['First']}_#{row['Last']}"
    next if name.nil? || name.strip.empty?
    
    slug = slugify(name)
    filename = "#{profiles_dir}/#{slug}.md"
    
    # Check for profile image using first_last_1 naming convention
    image_path = nil
    first_name = row['First'].to_s.downcase.strip
    last_name = row['Last'].to_s.downcase.strip
    
    ['jpg', 'jpeg', 'png'].each do |ext|
      potential_image = "assets/images/profiles/#{first_name}_#{last_name}_1.#{ext}"
      if File.exist?(potential_image)
        image_path = "/#{potential_image}"
        break
      end
    end
    
    # Prepare front matter
    front_matter = {
      'layout' => 'profile',
      'name' => "#{row['First']} #{row['Last']}",
      'organization' => row['Institution'],
      'department' => row['Department'],
      'project_title' => row['Title'],
      'status' => row['Status ']&.strip, # Note: CSV has trailing space
      'abstract' => row['Abstract ']&.strip, # Note: CSV has trailing space
      'academic_interests' => row['Academic/Research Interests'],
      'motivation' => row['Motivation'],
      'email' => row['Email'],
      'citizenship_status' => row['Citizenship Status'],
      'academic_status' => row['Academic Status'],
      'additional_comments' => row['Additional Comments'],
      'website' => row['Website'],
      'image' => image_path
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
