class ImportRecommendations < ActiveRecord::Migration
  class Recommendation < ActiveRecord::Base
    attr_accessible :quote, :who, :who_url, :where, :where_url, :position, :company, :company_url
  end

  def self.up

    [
      {
        :quote => "Great to work with, intelligent feedback, exceptional quality.",
        :who => "Matt Todd",
        :who_url => "http://www.workingwithrails.com/person/7298-matt-todd",
        :company_url => "http://highgroove.com/",
        :company => "Highgroove Studios",
        :where_url => "http://www.workingwithrails.com/recommendation/for/person/7844-tammer-saleh",
        :where => "WWR",
      },

      {
        :quote => "Tammer is a top-notch developer, project manager, scotch afficionado, and all-around awesome dude.",
        :who_url => "http://www.workingwithrails.com/person/2371",
        :who => "Jason Morrison",
        :company_url => "http://thoughtbot.com",
        :company => "Thoughtbot",
        :where_url => "http://www.workingwithrails.com/recommendation/for/person/7844-tammer-saleh",
        :where => "WWR",
      },

      {
        :quote => "Tammer has the extreme attention to detail and right kind of obsession with quality that most people have to lie about on their resumes.  As someone you can learn from everyday, he is both a pleasure and an asset to have as a colleague.",
        :who_url => "http://www.linkedin.com/profile?viewProfile=&key=7315120",
        :who => "Floyd Wright",
        :where_url => "http://www.linkedin.com/profile?viewProfile=&key=6604740#recommendations",
        :where => "LinkedIn",
      },

      {
        :quote => "Tammer has a seemingly relentless passion for excellent software practices, and an exacting eye for both others' work and his own. He comes packed with energy and focus, and is constantly looking for ways to improve himself.  I've benefited directly from Tammer's assistance and advice, and will make sure I continue to do so. ",
        :who_url => "http://www.mill-industries.com/",
        :who => "Eric Mill",
        :company_url => "http://sunlightlabs.com/",
        :company => "Sunlight Labs",
        :where_url => "http://www.linkedin.com/profile?viewProfile=&key=6604740#recommendations",
        :where => "LinkedIn",
      },

      {
        :quote => "Tammer was the guy at Caltech who could cut through the BS and get stuff done. He was very knowledgeable in the sys admin domain and kept the network together and improved it during his tenure at Caltech and left a legacy roadmap that was followed after he left. ",
        :who_url => "http://www.linkedin.com/pub/6/a88/835",
        :who => "Paul Friberg",
        :position => "owner",
        :company_url => "http://www.isti.com/about",
        :company => "ISTI",
        :where_url => "http://www.linkedin.com/profile?viewProfile=&key=6604740#recommendations",
        :where => "LinkedIn",
      },

      {
        :quote => "Tammer was a great guy to work with. He was the brains behind Carbon Rally and other cool projects at Thoughtbot. ",
        :who_url => "http://www.linkedin.com/pub/6/5b2/6a9",
        :who => "Jason Martinez",
        :company_url => "http://www.elctech.com/",
        :company => "ELC Technologies",
        :where_url => "http://www.linkedin.com/profile?viewProfile=&key=6604740#recommendations",
        :where => "LinkedIn",
      },

      {
        :quote => "A great and intelligent guy. Clearly an excellent coder. ",
        :who_url => "http://www.workingwithrails.com/person/5657-martin-emde",
        :who => "Martin Emde",
        :company_url => "http://engineyard.com",
        :company => "Engine Yard",
        :where_url => "http://www.workingwithrails.com/recommendation/for/person/7844-tammer-saleh",
        :where => "WWR",
      },

      {
        :quote => "Tammer is awesome. I shoulda tried shoulda a long time ago. (I bet you've never heard that before ;) ",
        :who_url => "http://www.workingwithrails.com/person/6290-steven-a-bristol",
        :who => "Steven A Bristol",
        :position => "owner",
        :company_url => "http://lesseverything.com/",
        :company => "Less Everything",
        :where_url => "http://www.workingwithrails.com/recommendation/for/person/7844-tammer-saleh",
        :where => "WWR",
      },

      {
        :quote => "Quality guy and talented to boot. ",
        :who_url => "http://www.workingwithrails.com/person/9803-jim-remsik",
        :who => "Jim Remsik",
        :company_url => "http://hashrocket.com",
        :company => "Hashrocket",
        :where_url => "http://www.workingwithrails.com/recommendation/for/person/7844-tammer-saleh",
        :where => "WWR",
      },

      {
        :quote => "Tammer has the mind and drive for writing disciplined, high-quality Ruby code. ",
        :who_url => "http://www.workingwithrails.com/person/1991-dan-croak",
        :who => "Dan Croak",
        :company_url => "http://thoughtbot.com",
        :company => "Thoughtbot",
        :where_url => "http://www.workingwithrails.com/recommendation/for/person/7844-tammer-saleh",
        :where => "WWR",
      },

      {
        :quote => "You're the werewolf! ",
        :who_url => "http://www.workingwithrails.com/person/5421-ezra-zygmuntowicz",
        :who => "Ezra Zygmuntowicz",
        :position => "founder",
        :company_url => "http://engineyard.com/",
        :company => "Engine Yard",
        :where_url => "http://www.workingwithrails.com/recommendation/for/person/7844-tammer-saleh",
        :where => "WWR",
      }
    ].each do |attributes|
      Recommendation.create!(attributes)
    end
  end

  def self.down
    Recommendation.destroy_all
  end
end
