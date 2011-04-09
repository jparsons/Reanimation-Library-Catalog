class RemoveLanguageAndLanguageIdFromItems < ActiveRecord::Migration
  def self.up
    %w(Arabic 	Italian
    Chinese 	Japanese
    French 	Korean
    German 	Polish
    Greek 	Portuguese
    Haitian-Creole 	Russian
    Hebrew 	Somali
    Hindi 	Spanish
    Irish-Gaelic 	Vietnamese
    English Esperanto).sort.each {|l|
      Language.find_or_create_by_name(l)
    }

    Item.each do |i|
      unless i.language.blank?
        l = Language.find_or_create_by_name(i.language)
        i.languages << l
      end


    end
    remove_column :items, :language
    remove_column :items, :language_id
  end

  def self.down
  end
end
