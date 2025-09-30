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
    
    # Check for profile image matching first_last pattern
    image_path = nil
    first_name = row['First'].to_s.downcase.strip
    last_name = row['Last'].to_s.downcase.strip
    
    # Look for any file that starts with first_last pattern
    image_dir = "assets/images/profiles/Letter-Number-Files"
    if Dir.exist?(image_dir)
      # Try different combinations for multi-word and hyphenated names
      name_combinations = [
        "#{first_name}_#{last_name.gsub(/[\s-]/, '_')}",  # Replace spaces and hyphens with underscores
        "#{first_name}_#{last_name.split(/[\s-]/).first}",  # First word of last name only
        "#{first_name}_#{last_name.split(/[\s-]/).last}",   # Last word of last name only
        "#{first_name}_#{last_name}"  # Original format (fallback)
      ].uniq
      
      name_combinations.each do |name_pattern|
        pattern = "#{name_pattern}_*"
        matching_files = Dir.glob("#{image_dir}/#{pattern}.{jpg,jpeg,png}", File::FNM_CASEFOLD)
        if matching_files.any?
          image_path = "/#{matching_files.first}"
          break
        end
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
    
    # Add Academic Interests section if available
    if front_matter['academic_interests'] && !front_matter['academic_interests'].strip.empty?
      content += "## Academic Interests\n\n"
      content += "#{front_matter['academic_interests']}\n\n"
    end
    
    # Add Motivation section if available
    if front_matter['motivation'] && !front_matter['motivation'].strip.empty?
      content += "## Motivation\n\n"
      content += "#{front_matter['motivation']}\n\n"
    end
    
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
