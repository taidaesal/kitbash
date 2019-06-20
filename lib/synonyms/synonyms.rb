module Kitbash
  module Synonyms
    require 'synonyms/bulk'

    @diminutives = %w(
      weak
      anemic
      feeble
      fragile
      frail
      wobbly
      unsteady
      shaky
      sickly
      sluggish
      uncertain
      flimsy
      flabby
      frail
      lame
      puny
      paltry
      tame
      dopey
      poor
      wimpy
      inferior
      insufficient
      meager
      mediocre
      miserable
      modest
      shoddy
      substandard
      dull
      so-so
      second-rate
      undistinguished
      uninspired
      middling
      ordinary
      faulty
      inadequate
      incomplete
      scant
      insecure
      rocky
      rickety
      precarious
      unsettled
      small
      limited
      microscopic
      minuscule
      short
      slight
      diminutive
    )

    @organizations = %w(
      organization
      grouping
      institution
      management
      system
      alignment
      constitution
      coordination
      order
      structure
      gang
    )

    @superlatives = %w(
      superlative
      magnificent
      outstanding
      peerless
      superb
      transcendent
      unparalleled
      brilliant
      excellent
      grand
      grandiose
      imposing
      impressive
      lofty
      noble
      outstanding
      splendid
      striking
      sublime
      towering
      beautiful
      dazzling
      bright
      marvelous
      finest
      first
      leading
      first-rate
      terrific
      perfect
      impeccable
      flawless
      absolute
      ideal
      strong
      able
      capable
      firm
      forceful
      durable
      big
      very
      extremely
      vigorous
      stable
      steady
      tenacious
      tough
      reliable
      safe
      solid
      substantial
    )

    @trendy = %w(
      blockchain
      IOT-Ready
      IOT
      connected
      social
      networked
      responsive
      2.0
      platform
      ecosystem
      synergy
      rightsizing
      ecosystem
      ideation
      bandwidth
      disrupt
      5G
      4G
      iterate
      sunset
      rockstar
      guru
      web
      roadmap
      hack
      unicorn
    )

    @users = %w(
      user
      member
      representative
      affiliate
      associate
      assistant
      co-worker
      collaborator
      companion
      comrade
      fellow
      friend
      partner
      person
      character
      individual
      somebody
      customer
      human
    )

    def Synonyms.diminutives
      index = SecureRandom.random_number(@diminutives.count)
      @diminutives[index]
    end

    def Synonyms.organizations
      index = SecureRandom.random_number(@organizations.count)
      @organizations[index]
    end

    def Synonyms.software
      index = SecureRandom.random_number(Bulk.software.count)
      Bulk.software[index]
    end

    def Synonyms.sports
      index = SecureRandom.random_number(Bulk.sports.count)
      Bulk.sports[index]
    end

    def Synonyms.studies
      index = SecureRandom.random_number(Bulk.studies.count)
      Bulk.studies[index]
    end

    def Synonyms.superlatives
      index = SecureRandom.random_number(@superlatives.count)
      @superlatives[index]
    end

    def Synonyms.trendy
      index = SecureRandom.random_number(@trendy.count)
      @trendy[index]
    end

    def Synonyms.users
      index = SecureRandom.random_number(@users.count)
      @users[index]
    end
  end
end