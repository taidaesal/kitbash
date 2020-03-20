module Kitbash
  module Bulk
    module OrganizationsBulk

      private

      def adjectives
        @@adjectives ||= %w(
          different
          used
          important
          every
          large
          available
          popular
          able
          basic
          known
          various
          difficult
          several
          united
          historical
          useful
          scared
          additional
          emotional
          old
          political
          similar
          healthy
          financial
          medical
          traditional
          federal
          entire
          strong
          actual
          significant
          successful
          electrical
          expensive
          intelligent
          interesting
          happy
          responsible
          cute
          helpful
          recent
          willing
          nice
          wonderful
          impossible
          serious
          huge
          rare
          technical
          typical
          competitive
          critical
          electronic
          immediate
          aware
          educational
          environmental
          global
          legal
          relevant
          accurate
          capable
          dangerous
          dramatic
          efficient
          powerful
          foreign
          practical
          psychological
          severe
          suitable
          numerous
          sufficient
          unusual
          consistent
          cultural
          existing
          famous
          pure
          afraid
          obvious
          careful
          acceptable
          aggressive
          distinct
          eastern
          logical
          reasonable
          strict
          administrative
          automatic
          civil
          massive
          southern
          visible
          desperate
          exciting
          friendly
          lucky
          realistic
          sorry
          ugly
          unlikely
          anxious
          comprehensive
          curious
          impressive
          informal
          inner
          pleasant
          sudden
          terrible
          unable
          weak
          wooden
          confident
          conscious
          decent
          embarrassed
          lonely
          mad
          nervous
          remarkable
          substantial
          suspicious
          tall
          tiny
          other
          such
          even
          new
          just
          good
          each
          much
          great
          another
          same
          free
          right
          still
          best
          public
          human
          local
          sure
          better
          general
          specific
          enough
          long
          small
          high
          certain
          little
          common
          next
          simple
          hard
          past
          big
          possible
          particular
          real
          major
          personal
          current
          left
          national
          least
          natural
          physical
          short
          last
          single
          individual
          potential
          professional
          international
          lower
          open
          according
          alternative
          special
          working
          whole
          clear
          dry
          easy
          cold
          commercial
          full
          low
          primary
          worth
          necessary
          positive
          present
          close
          creative
          green
          late
          fit
          glad
          proper
          complex
          content
          effective
          middle
          regular
          fast
          independent
          original
          wide
          beautiful
          complete
          active
          negative
          safe
          visual
          wrong
          quick
          ready
          straight
          white
          direct
          excellent
          extra
          junior
          pretty
          unique
          classic
          final
          overall
          private
          separate
          western
          alone
          familiar
          official
          perfect
          bright
          broad
          comfortable
          flat
          rich
          warm
          young
          heavy
          valuable
          correct
          leading
          slow
          clean
          fresh
          normal
          secret
          tough
          brown
          cheap
          deep
          objective
          secure
          thin
          chemical
          cool
          extreme
          exact
          fair
          fine
          formal
          opposite
          remote
          total
          vast
          lost
          smooth
          dark
          double
          equal
          firm
          frequent
          internal
          sensitive
          constant
          minor
          previous
          raw
          soft
          solid
          weird
          amazing
          annual
          busy
          false
          round
          sharp
          thick
          wise
          equivalent
          initial
          narrow
          nearby
          proud
          spiritual
          wild
          adult
          apart
          brief
          crazy
          prior
          rough
          sad
          sick
          strange
          external
          illegal
          loud
          mobile
          nasty
          ordinary
          royal
          senior
          super
          tight
          upper
          yellow
          dependent
          funny
          gross
          ill
          spare
          sweet
          upstairs
          usual
          brave
          calm
          dirty
          downtown
          grand
          honest
          loose
          male
          quiet
          brilliant
          dear
          drunk
          empty
          inevitable
          neat
          ok
          representative
          slight
          smart
          stupid
          temporary
          weekly
          time
          work
          first
          money
          over
          business
          game
          think
          after
          life
          day
          home
          economy
          away
          either
          key
          training
          top
          level
          house
          kind
          future
          action
          live
          period
          subject
          mean
          stock
          chance
          beginning
          upset
          chicken
          head
          material
          appropriate
          inside
          outside
          standard
          medium
          choice
          north
          square
          capital
          front
          living
          plastic
          express
          feeling
          otherwise
          savings
          animal
          budget
          character
          maximum
          novel
          plenty
          select
          background
          forward
          glass
          joint
          master
          vegetable
          ideal
          kitchen
          party
          relative
          signal
          street
          connect
          minimum
          sea
          status
          afternoon
          gold
          mission
          agent
          corner
          routine
          swimming
          winter
          airline
          designer
          dress
          emergency
          extension
          holiday
          horror
          mountain
          patient
          proof
          west
          wine
          expert
          native
          opening
          silver
          waste
          plane
          leather
          specialist
          bitter
          incident
          motor
          pretend
          prize
          resident
        )
      end

      def nouns
        @@nouns ||= %w(
          people
          history
          art
          world
          information
          map
          family
          government
          health
          system
          computer
          meat
          year
          thanks
          music
          person
          reading
          method
          data
          food
          understanding
          theory
          law
          bird
          literature
          problem
          software
          control
          knowledge
          power
          ability
          economics
          love
          internet
          television
          science
          library
          nature
          fact
          product
          idea
          temperature
          investment
          area
          society
          activity
          story
          industry
          media
          oven
          community
          definition
          safety
          quality
          development
          language
          management
          player
          variety
          video
          security
          country
          exam
          movie
          organization
          equipment
          physics
          analysis
          policy
          series
          thought
          basis
          direction
          strategy
          technology
          camera
          freedom
          paper
          environment
          instance
          marketing
          university
          writing
          article
          department
          difference
          news
          audience
          fishing
          growth
          income
          marriage
          combination
          failure
          meaning
          medicine
          philosophy
          teacher
          communication
          chemistry
          disease
          disk
          energy
          nation
          soup
          advertising
          location
          success
          addition
          apartment
          education
          math
          moment
          painting
          politics
          attention
          decision
          event
          property
          shopping
          student
          wood
          competition
          distribution
          entertainment
          office
          population
          president
          category
          context
          introduction
          opportunity
          performance
          driver
          flight
          length
          relationship
          teaching
          finding
          lake
          message
          phone
          scene
          appearance
          association
          concept
          discussion
          housing
          inflation
          insurance
          mood
          advice
          blood
          effort
          expression
          importance
          opinion
          payment
          reality
          responsibility
          situation
          skill
          statement
          wealth
          application
          depth
          heart
          perspective
          photo
          recipe
          studio
          topic
          collection
          depression
          imagination
          passion
          percentage
          resource
          setting
          agency
          college
          connection
          criticism
          debt
          description
          memory
          patience
          secretary
          solution
          administration
          aspect
          attitude
          director
          personality
          psychology
          recommendation
          response
          selection
          storage
          version
          argument
          complaint
          contract
          emphasis
          highway
          membership
          possession
          preparation
          steak
          union
          currency
          employment
          engineering
          entry
          interaction
          mixture
          preference
          region
          tradition
          virus
          actor
          classroom
          delivery
          device
          difficulty
          drama
          election
          engine
          football
          guidance
          hotel
          owner
          priority
          protection
          suggestion
          tension
          variation
          anxiety
          atmosphere
          awareness
          bath
          bread
          candidate
          climate
          comparison
          confusion
          construction
          elevator
          emotion
          employer
          height
          leadership
          mall
          manager
          operation
          recording
          sample
          charity
          cousin
          disaster
          editor
          efficiency
          excitement
          extent
          feedback
          guitar
          homework
          leader
          outcome
          permission
          presentation
          promotion
          reflection
          refrigerator
          resolution
          revenue
          session
          singer
          tennis
          basket
          bonus
          cabinet
          childhood
          church
          clothes
          coffee
          dinner
          drawing
          hair
          hearing
          initiative
          judgment
          lab
          measurement
          mode
          orange
          poetry
          police
          possibility
          procedure
          queen
          ratio
          relation
          restaurant
          satisfaction
          sector
          signature
          significance
          song
          town
          vehicle
          volume
          accident
          airport
          appointment
          arrival
          assumption
          baseball
          chapter
          committee
          conversation
          database
          enthusiasm
          error
          explanation
          farmer
          gate
          historian
          hospital
          injury
          instruction
          maintenance
          manufacturer
          meal
          perception
          pie
          poem
          presence
          proposal
          reception
          replacement
          revolution
          river
          speech
          tea
          village
          warning
          winner
          writer
          assistance
          breath
          buyer
          chest
          chocolate
          conclusion
          contribution
          cookie
          courage
          desk
          drawer
          establishment
          examination
          grocery
          honey
          impression
          improvement
          independence
          inspection
          inspector
          ladder
          menu
          penalty
          piano
          profession
          professor
          quantity
          reaction
          requirement
          salad
          supermarket
          tongue
          weakness
          wedding
          affair
          ambition
          analyst
          assignment
          assistant
          bathroom
          bedroom
          birthday
          celebration
          championship
          consequence
          departure
          diamond
          dirt
          fortune
          friendship
          funeral
          hat
          indication
          intention
          midnight
          negotiation
          obligation
          passenger
          platform
          poet
          pollution
          recognition
          reputation
          shirt
          surgery
          sympathy
          tale
          throat
          trainer
          time
          work
          film
          water
          money
          example
          business
          study
          game
          life
          form
          air
          part
          field
          fish
          back
          process
          heat
          hand
          experience
          job
          book
        )
      end

      def default_orgs
        @@default_orgs ||= [
            {
                "name": "Ihoysoft",
                "url": "ihoysoft.cc.info"
            },
            {
                "name": "Oeptel",
                "url": "oeptel.ly"
            },
            {
                "name": "Yretech",
                "url": "yretech.org"
            },
            {
                "name": "EhoCO",
                "url": "ehoco.net"
            },
            {
                "name": "Eapon",
                "url": "eapon.it"
            },
            {
                "name": "Adpco",
                "url": "adpco.gov"
            },
            {
                "name": "Ayhion",
                "url": "ayhion.com"
            },
            {
                "name": "Azxtek",
                "url": "azxtek.net"
            },
            {
                "name": "Aevitech",
                "url": "aevitech.su.net"
            },
            {
                "name": "Ezutech",
                "url": "ezutech.fr.int"
            },
            {
                "name": "Eoxro",
                "url": "eoxro.net"
            },
            {
                "name": "Xisoft",
                "url": "xisoft.com"
            },
            {
                "name": "EasyCO",
                "url": "easyco.com"
            },
            {
                "name": "Ubytouch",
                "url": "ubytouch.int"
            },
            {
                "name": "Yitoco",
                "url": "yitoco.uk.com"
            },
            {
                "name": "Yhbon",
                "url": "yhbon.net"
            },
            {
                "name": "Seuos",
                "url": "seuos.su.net"
            },
            {
                "name": "Joconn",
                "url": "joconn.org"
            },
            {
                "name": "Dyotek",
                "url": "dyotek.net"
            },
            {
                "name": "Rihtek",
                "url": "rihtek.us.int"
            },
            {
                "name": "Pipath",
                "url": "pipath.org"
            },
            {
                "name": "Gios",
                "url": "gios.ly"
            },
            {
                "name": "Tirus",
                "url": "tirus.com"
            },
            {
                "name": "Speech Institution",
                "url": "speech.institution.jp.int"
            },
            {
                "name": "Enthusiasm Structure",
                "url": "enthusiasm.structure.edu"
            },
            {
                "name": "Satisfaction Order",
                "url": "satisfaction.order.int"
            },
            {
                "name": "Buyer Co",
                "url": "buyer_co.info"
            },
            {
                "name": "Assistance Cast",
                "url": "assistance.cast.net"
            },
            {
                "name": "Cabinet Management",
                "url": "cabinet_management.org"
            },
            {
                "name": "Obligation Order",
                "url": "obligation.order.info"
            },
            {
                "name": "Virus Institution",
                "url": "virus_institution.org"
            },
            {
                "name": "Studio Touch",
                "url": "studio.touch.co.info"
            },
            {
                "name": "Statement Conn",
                "url": "statement.conn.su.org"
            },
            {
                "name": "Leadership Port",
                "url": "leadership.port.org"
            },
            {
                "name": "Solution Grouping",
                "url": "solution.grouping.com"
            },
            {
                "name": "Theory Co",
                "url": "theory.co.ly"
            },
            {
                "name": "Supermarket Co",
                "url": "supermarket.co.info"
            },
            {
                "name": "Atmosphere",
                "url": "atmosphere.ly"
            },
            {
                "name": "Recognition Institution",
                "url": "recognition.institution.ly"
            },
            {
                "name": "Response Management",
                "url": "response.management.com"
            },
            {
                "name": "Measurement",
                "url": "measurement.mil"
            },
            {
                "name": "Enthusiasm",
                "url": "enthusiasm.com"
            },
            {
                "name": "Ladder Co",
                "url": "ladder.co.uk.info"
            },
            {
                "name": "Person Management",
                "url": "person.management.com"
            },
            {
                "name": "Huntington Beach Pop",
                "url": "HBP.edu"
            },
            {
                "name": "Perfect Miramar System",
                "url": "PMS.int"
            },
            {
                "name": "Richmond Tech",
                "url": "richmond.tech.eu.edu"
            },
            {
                "name": "Kent Order",
                "url": "kent.order.info"
            },
            {
                "name": "Maryland Tel",
                "url": "maryland.tel.jp.it"
            },
            {
                "name": "Sandy Springs Flix",
                "url": "SSF.it"
            },
            {
                "name": "Macon Coordination",
                "url": "macon.coordination.ly"
            },
            {
                "name": "Massachusetts Rus",
                "url": "massachusetts.rus.ly"
            },
            {
                "name": "Manchester Alia",
                "url": "manchester.alia.jp.info"
            },
            {
                "name": "Perfect Arizona",
                "url": "perfect.arizona.gov"
            },
            {
                "name": "Burbank Co",
                "url": "burbank.co.mil"
            },
            {
                "name": "Kansas Conn",
                "url": "kansas_conn.net"
            },
            {
                "name": "According Environment",
                "url": "according.environment.uk"
            },
            {
                "name": "Aware Writer",
                "url": "aware_writer.ly"
            },
            {
                "name": "Remote Responsibility",
                "url": "remote.responsibility.org"
            },
            {
                "name": "Home Need",
                "url": "home.need.com"
            },
            {
                "name": "Cultural Consequence",
                "url": "cultural.consequence.it"
            },
            {
                "name": "Private Film Mart",
                "url": "filmmart.org"
            },
            {
                "name": "Still World",
                "url": "still.world.it"
            },
            {
                "name": "Overall Solution Path",
                "url": "solutionpath.org"
            },
            {
                "name": "Global Setting Tek",
                "url": "globalsetting.it"
            },
            {
                "name": "Still Operation Tech",
                "url": "Still.us.net"
            },
            {
                "name": "Raw Systems",
                "url": "raw.systems.us.it"
            },
            {
                "name": "Honest Systems",
                "url": "honest.systems.net"
            },
            {
                "name": "Helpful Hearing Co",
                "url": "hearingco.net"
            },
            {
                "name": "Live Bright",
                "url": "live.bright.it"
            },
            {
                "name": "Emotional Imagination",
                "url": "emotional_imagination.it"
            },
            {
                "name": "Say Marketing",
                "url": "say_marketing.gov"
            }
        ]
      end

      def verbs
        @@verbs ||= %w(
          ask
          be
          become
          begin
          call
          can
          come
          could
          do
          feel
          find
          get
          give
          go
          have
          hear
          help
          keep
          know
          leave
          let
          like
          live
          look
          make
          may
          mean
          might
          move
          need
          play
          put
          run
          say
          see
          seem
          should
          show
          start
          take
          talk
          tell
          think
          try
          turn
          use
          want
          will
          work
          would
        )
      end
    end
  end
end
