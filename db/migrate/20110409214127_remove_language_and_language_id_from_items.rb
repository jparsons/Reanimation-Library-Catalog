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
      Language.find_or_create_by(name: l)
    }

    Item.all.each do |i|
      unless i.language.blank?
        l = Language.find_or_create_by(name: i.language)
        i.languages << l
      end


    end
    remove_column :items, :language
    remove_column :items, :language_id
  end

  def self.down
  end
end
