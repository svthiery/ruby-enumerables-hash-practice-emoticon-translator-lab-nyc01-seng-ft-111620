require "yaml"
require 'pry'

def load_library(yaml_file)
  emoticons = YAML.load_file(yaml_file)
  emoticons.map do |key, value|
    value.unshift(:english)
    value.insert(2, :japanese)
  end
  emoticons.map do |key, value|
    array_one = [value[0], value[1]]
    array_two = [value[2], value[3]]
    final_array = [array_one, array_two]
    emoticons[key] = final_array
  end
  emoticons.map do |key, value|
    emoticons[key] = value.to_h
  end
  emoticons
end

def get_japanese_emoticon(yaml_file, emoticon)
  emoticons = load_library(yaml_file)
  emoticons.each do |description_keys, languages|
    languages.each do |eng_or_jap, face|
      if face == emoticon
        return emoticons[description_keys][:japanese]
      end
    end
  end
  return "Sorry, that emoticon was not found"
end

def get_english_meaning(yaml_file, emoticon)
  emoticons = load_library(yaml_file)
  emoticons.each do |description_keys, languages|
    languages.each do |eng_or_jap, face|
      if face == emoticon
        return description_keys
      end
    end
  end
  return "Sorry, that emoticon was not found"
end
