#!/usr/bin/env ruby

require 'csv'
require 'yaml'

# Helper script to convert CSV profile data to Jekyll profile pages

def slugify(text)
  text.to_s.downcase.strip.gsub(/[^a-z0-9\s-]/, '').gsub(/\s+/, '-').gsub(/-+/, '-')
end

def get_photo_filename(first_name, last_name)
  # Convert name to expected filename format
  name_slug = "#{first_name.downcase.strip.gsub(/\s+/, '_')}_#{last_name.downcase.strip.gsub(/\s+/, '_')}"
  
  # Check for common extensions in assets/staff_pictures
  ['jpg', 'jpeg', 'png', 'gif'].each do |ext|
    filename = "#{name_slug}.#{ext}"
    if File.exist?("assets/staff_pictures/#{filename}")
      return filename
    end
  end
  
  # Return nil if no photo found
  return nil
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
    # Skip Submission column - not needed for display
    first_name = row['First/Given Names (first)']
    last_name = row['Last/Family Name (first)']
    
    next if first_name.nil? || last_name.nil? || first_name.strip.empty? || last_name.strip.empty?
    
    name = "#{first_name} #{last_name}"
    slug = slugify(name)
    filename = "#{profiles_dir}/#{slug}.md"
    
    # Get actual photo filename based on name
    photo_filename = get_photo_filename(first_name, last_name)
    
    # Prepare front matter - map all CSV columns except Submission and Status
    front_matter = {
      'layout' => 'profile',
      'name' => name,
      'first_name' => first_name,
      'last_name' => last_name,
      'email' => row['Email (first)'],
      'institution' => row['Company/Institution (first)'],
      'department' => row['Department (first)'],
      'photo' => photo_filename,
      'website' => row['Website (first)'],
      'biography' => row['Biography (Maximum 200 words)'],
      'project_title' => row['SRP Project Title (first)'],
      'nairr_project' => row['What is the NAIRR Project Name? (first)'],
      'hpsf_project' => row['What is the HPSF Project Name? (first)'],
      'topical_areas' => row['Please select all the topical areas that apply to your project: (first)'],
      'abstract' => row['Brief Abstract (200 words) (first)'],
      'desired_skills' => row['Desired relevant skills, background, or interests (don\'t be too prescriptive) (first)'],
      'comments' => row['Any other comments (first)'],
      'lightning_talk_title' => row['Lightning Talk Title (Maximum 10 words)'],
      'keywords' => row['Keywords (Maximum 20 words)']
    }
    
    # Remove empty fields
    front_matter.reject! { |k, v| v.nil? || v.strip.empty? }
    
    # Create the profile page content
    content = "---\n"
    content += front_matter.to_yaml.gsub(/^---\n/, '')
    content += "---\n"
    
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
