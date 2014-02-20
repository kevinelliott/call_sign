require 'iso3166'

module CallSign
  class ITUPrefix

    # TODO: Find a way to refactor this into datafile without losing performance
    PREFIXES = {}

    # Extracted from the ITU Table of International Call Sign Series (Appendix 42)
    # Ranges: http://www.itu.int/online/mms/glad/cga_callsign.sh?lng=E
    # Keys:   http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    PREFIXES_BY_COUNTRY = {
      afg: ['T6', 'T6A'..'T6Z', 'YA', 'YAA'..'YAZ'],
      ago: ['D2A'..'D3Z'],
      alb: ['ZA', 'ZAA'..'ZAZ'],
      and: ['C3A'..'C3Z'],
      are: ['A6A'..'A6Z'],
      arg: ['AYA'..'AZZ', 'L2A'..'L9Z', 'LOA'..'LWZ'],
      arm: ['EKA'..'EKZ'],
      asm: ['5WA'..'5WZ'],
      atg: ['V2', 'V2A'..'V2Z'],
      aus: ['AX', 'AXA'..'AXZ', 'VH'..'VN', 'VHA'..'VNZ', 'VZ', 'VZA'..'VZZ'],
      aut: ['OEA'..'OEZ'],
      aze: ['4JA'..'4KA'],
      bdi: ['9UA'..'9UZ'],
      bel: ['ONA'..'OTZ'],
      ben: ['TY', 'TYA'..'TYZ'],
      bes: ['PJ', 'PJA'..'PJZ'],
      bfa: ['XT', 'XTA'..'XTZ'],
      bgr: ['LZA'..'LZZ'],
      bhr: ['A9A'..'A9Z'],
      bhs: ['C6A'..'C6Z'],
      bih: ['E7A'..'E7Z'],
      blr: ['EUA'..'EWZ', 'S2A'..'S3Z'],
      blz: ['V3', 'V3A'..'V3Z'],
      bol: ['CPA'..'CPZ'],
      bra: ['PP'..'PY', 'PPA'..'PYZ', 'ZV'..'ZZ', 'ZVA'..'ZZZ'],
      brb: ['8PA'..'8PZ'],
      brn: ['V8', 'V8A'..'V8Z'],
      btn: ['A5A'..'A5Z'],
      bwa: ['8OA'..'8OZ', 'A2A'..'A2Z'],
      caf: ['TL', 'TLA'..'TLZ'],
      can: ['CF'..'CK', 'CFA'..'CKZ', 'CY'..'CZ', 'CYA'..'CZZ', 'VA'..'VG', 'VAA'..'VGZ', 'VO', 'VOA'..'VOZ', 'VX'..'VY', 'VXA'..'VYZ', 'XJ'..'XO', 'XJA'..'XOZ'],
      che: ['HBA'..'HBZ', 'HEA'..'HEZ'],
      chl: ['3GA'..'3GZ', 'CA'..'CE', 'CAA'..'CEZ', 'XQ'..'XR', 'XQA'..'XRZ'],
      chn: ['3HA'..'3UZ', 'B', 'BA'..'BZ', 'BAA'..'BZZ', 'VR', 'VRA'..'VRZ', 'XS', 'XSA'..'XSZ', 'XX', 'XXA'..'XXZ', 'XS', 'XSA'..'XSZ', 'XX', 'XXA'..'XXZ'],
      civ: ['TU', 'TUA'..'TUZ'],
      cmr: ['TJ', 'TJA'..'TJZ'],
      cod: ['9OA'..'9TZ'],
      cog: ['TN', 'TNA'..'TNZ'],
      cok: ['E5A'..'E5Z'],
      col: ['5JA'..'5KZ', 'HJA'..'HKZ'],
      com: ['D6A'..'D6Z'],
      cpv: ['D4A'..'D4Z'],
      cri: ['TE', 'TEA'..'TEZ', 'TI', 'TIA'..'TIZ'],
      cub: ['CL'..'CM', 'CLA'..'CMZ', 'CO', 'COA'..'COZ', 'T4', 'T4A'..'T4Z'],
      cuw: ['PJA'..'PJZ'],
      cyp: ['5BA'..'5BZ', 'C4A'..'C4Z', 'H2A'..'H2Z', 'P3A'..'P3Z'],
      cze: ['OKA'..'OLZ'],
      den: ['XP', 'XPA'..'XPZ'],
      deu: ['DA'..'DR', 'DAA'..'DRZ', 'Y2A'..'Y9Z'],
      dji: ['J2A'..'J2Z'],
      dma: ['J7A'..'J7Z'],
      dnk: ['5PA'..'5QZ', 'OUA'..'OZZ'],
      dom: ['HIA'..'HIZ'],
      dza: ['7RA'..'7RZ', '7TA'..'7YZ'],
      ecu: ['HCA'..'HDZ'],
      egy: ['6A'..'6B', '6AA'..'6BZ', 'SSA'..'SSM', 'SU', 'SUA'..'SUZ'],
      eri: ['E3A'..'E3Z'],
      esp: ['AMA'..'AOZ', 'EAA'..'EHZ'],
      est: ['ESA'..'ESZ'],
      eth: ['9EA'..'9FZ', 'ETA'..'ETZ'],
      fin: ['OFA'..'OJZ'],
      fji: ['3DN'..'3DZ'],
      fra: ['F', 'FA'..'FZ', 'FAA'..'FZZ', 'HW'..'HY', 'HWA'..'HYZ', 'TH', 'THA'..'THZ', 'TK', 'TKA'..'TKZ', 'TM', 'TMA'..'TMZ', 'TO'..'TQ', 'TOA'..'TQZ', 'TV'..'TX', 'TVA'..'TXZ'],
      fsm: ['V6', 'V6A'..'V6Z'],
      gab: ['TR', 'TRA'..'TRZ'],
      gbr: ['2AA'..'2ZZ', 'G', 'GA'..'GZ', 'GAA'..'GZZ', 'M', 'MA'..'MZ', 'MAA'..'MZZ', 'VP'..'VQ', 'VPA'..'VQZ', 'VS', 'VSA'..'VSZ', 'ZB'..'ZJ', 'ZBA'..'ZJZ', 'ZN'..'ZO', 'ZNA'..'ZOZ', 'ZQ', 'ZQA'..'ZQZ', 'ZB'..'ZJ', 'ZBA'..'ZJZ', 'ZN'..'ZO', 'ZNA'..'ZOZ', 'ZQ', 'ZQA'..'ZQZ'],
      geo: ['4LA'..'4LZ'],
      gha: ['9GA'..'9GZ'],
      gin: ['3XA'..'3XZ'],
      gmb: ['C5A'..'C5Z'],
      gnb: ['J5A'..'J5Z'],
      gnq: ['3CA'..'3CQ'],
      grc: ['J4A'..'J4Z', 'SV'..'SZ', 'SVA'..'SZZ'],
      grd: ['J3A'..'J3Z'],
      gtm: ['TD', 'TDA'..'TDZ', 'TG', 'TGA'..'TGZ'],
      guy: ['8RA'..'8RZ'],
      hnd: ['HQA'..'HRZ'],
      hun: ['HAA'..'HAZ', 'HGA'..'HGZ'],
      hrv: ['9AA'..'9AZ'],
      hti: ['4VA'..'4VZ', 'HHA'..'HHZ'],
      idn: ['7AA'..'7IZ', '8AA'..'8IZ', 'JZ', 'JZA'..'JZZ', 'PK'..'PO', 'PKA'..'POZ', 'YB'..'YH', 'YBA'..'YHZ'],
      ind: ['8TA'..'8YZ', 'AT'..'AW', 'ATA'..'AWZ', 'VT'..'VW', 'VTA'..'VWZ'],
      irl: ['EI'..'EJ', 'EIA'..'EJZ', 'TF', 'TFA'..'TFZ'],
      irn: ['9BA'..'9DZ', 'EPA'..'EQZ'],
      irq: ['HN', 'HNA'..'HNZ', 'YI', 'YIA'..'YIZ'],
      isr: ['4XA'..'4XZ', '4ZA'..'4ZZ'],
      ita: ['I', 'IAA'..'IZZ'],
      jam: ['6YA'..'6YZ'],
      jor: ['JYA'..'JYZ'],
      jpn: ['7JA'..'7NZ', '8JA'..'8NZ', 'JAA'..'JSZ'],
      kaz: ['UN'..'UQ', 'UNA'..'UQZ'],
      ken: ['5YA'..'5ZZ'],
      kgz: ['EXA'..'EXZ'],
      khm: ['XU', 'XUA'..'XUZ'],
      kir: ['T3', 'T3A'..'T3Z'],
      kna: ['V4', 'V4A'..'V4Z'],
      kor: ['6KA'..'6NZ', 'D7A'..'D9Z', 'DSA'..'DTZ', 'HLA'..'HLZ'],
      kwt: ['9KA'..'9KZ'],
      lao: ['XW', 'XWA'..'XWZ'],
      lbn: ['ODA'..'ODZ'],
      lbr: ['5LA'..'5MZ', '6ZA'..'6ZZ', 'A8A'..'A8Z', 'D5A'..'D5Z', 'ELA'..'ELZ'],
      lby: ['5AA'..'5AZ'],
      lca: ['J6A'..'J6Z'],
      lka: ['4PA'..'4SZ'],
      lso: ['7PA'..'7PZ'],
      ltu: ['LYA'..'LYZ'],
      lux: ['LXA'..'LXZ'],
      lva: ['YL', 'YLA'..'YLZ'],
      mar: ['5CA'..'5GZ', 'CNA'..'CNZ'],
      mco: ['3AA'..'3AZ'],
      mda: ['ERA'..'ERZ'],
      mdg: ['5RA'..'5SZ', '6XA'..'6XZ'],
      mdv: ['8QA'..'8QZ'],
      mex: ['4AA'..'4CZ', '6DA'..'6JZ', 'XA'..'XI', 'XAA'..'XIZ'],
      mhl: ['V7', 'V7A'..'V7Z'],
      mkd: ['Z3A'..'Z3Z'],
      mli: ['TZ', 'TZA'..'TZZ'],
      mlt: ['9HA'..'9HZ'],
      mmr: ['XY'..'XZ', 'XYA'..'XZZ'],
      mne: ['4OA'..'4OZ'],
      mng: ['JTA'..'JVZ'],
      moz: ['C8A'..'C9Z'],
      mrt: ['5TA'..'5TZ'],
      mus: ['3BA'..'3BZ'],
      mwi: ['7QA'..'7QZ'],
      mys: ['9MA'..'9MZ', '9WA'..'9WZ'],
      nam: ['V5', 'V5A'..'V5Z'],
      nga: ['5NA'..'5OZ', '5UA'..'5UZ'],
      nic: ['H6A'..'H7Z', 'HT', 'HTA'..'HTZ', 'YN', 'YNA'..'YNZ'],
      niu: ['E6A'..'E6Z'],
      nld: ['P4A'..'P4Z', 'PAA'..'PIZ'],
      nor: ['3YA'..'3YZ', 'JWA'..'JWZ', 'LAA'..'LNZ'],
      npl: ['9NA'..'9NZ'],
      nru: ['C2A'..'C2Z'],
      nzl: ['ZK'..'ZM', 'ZKA'..'ZMZ'],
      omn: ['A4A'..'A4Z'],
      pak: ['6PA'..'6SZ', 'APA'..'ASZ'],
      pan: ['3EA'..'3FZ', 'H3A'..'H3Z', 'H8A'..'H9Z', 'HOA'..'HPZ'],
      per: ['4TA'..'4TZ', 'OAA'..'OCZ'],
      phl: ['4DA'..'4IZ', 'DUA'..'DZZ'],
      plw: ['T8', 'T8A'..'T8Z'],
      png: ['P2A'..'P2Z'],
      pol: ['3Z', '3ZA'..'3ZZ', 'HF', 'HFA'..'HFZ', 'SN'..'SR', 'SNA'..'SRZ'],
      prk: ['HMA'..'HMZ', 'P5A'..'P9Z'],
      prt: ['CQA'..'CUZ'],
      pry: ['ZP', 'ZPA'..'ZPZ'],
      pse: ['E4A'..'E4Z'],
      qat: ['A7A'..'A7Z'],
      rou: ['YO'..'YR', 'YOA'..'YRZ'],
      rus: ['R', 'RA'..'RZ', 'RAA'..'RZZ', 'UA'..'UI', 'UAA'..'UIZ'],
      rwa: ['9XA'..'9XZ'],
      sau: ['7ZA'..'7ZZ', '8ZA'..'8ZZ', 'HZA'..'HZZ'],
      sdn: ['6TA'..'6UZ', 'SSN'..'SSZ', 'ST', 'STA'..'STZ'],
      sen: ['6VA'..'6WZ'],
      sgp: ['9VA'..'9VZ', 'S6A'..'S6Z'],
      slb: ['H4A'..'H4Z'],
      sle: ['9LA'..'9LZ'],
      slv: ['HU', 'HUA'..'HUZ', 'YS', 'YSA'..'YSZ'],
      smr: ['T7', 'T7A'..'T7Z'],
      som: ['6O', '6OA'..'6OZ', 'T5', 'T5A'..'T5Z'],
      srb: ['YT'..'YU', 'YTA'..'YUZ'],
      ssd: ['Z8A'..'Z8Z'],
      stp: ['S9A'..'S9Z'],
      sur: ['PZA'..'PZZ'],
      svn: ['S5A'..'S5Z'],
      svk: ['OMA'..'OMZ'],
      swe: ['8SA'..'8SZ', 'SA'..'SM', 'SAA'..'SMZ'],
      swz: ['3DA'..'3DM'],
      syc: ['S7A'..'S7Z'],
      syr: ['6CA'..'6CZ', 'YK', 'YKA'..'YKZ'],
      tcd: ['TT', 'TTA'..'TTZ'],
      tgo: ['5VA'..'5VZ'],
      tha: ['E2A'..'E2Z', 'HSA'..'HSZ'],
      tkm: ['EZA'..'EZZ'],
      tjk: ['EYA'..'EYZ'],
      tls: ['4WA'..'4WZ'],
      ton: ['A3A'..'A3Z'],
      tto: ['9YA'..'9ZZ'],
      tun: ['TS', 'TSA'..'TSZ'],
      tur: ['TA'..'TC', 'TAA'..'TCZ', 'YM', 'YMA'..'YMZ'],
      tuv: ['T2', 'T2A'..'T2Z'],
      tza: ['5HA'..'5IZ'],
      tun: ['3VA'..'3VZ'],
      uga: ['5XA'..'5XZ'],
      ukr: ['EM'..'EO', 'EMA'..'EOZ', 'UR'..'UZ', 'URA'..'UZZ'],
      ury: ['CVA'..'CXZ'],
      usa: ['AA'..'AL', 'AAA'..'ALZ', 'K', 'KA'..'KZ', 'KAA'..'KZZ', 'N', 'NA'..'NZ', 'NAA'..'NZZ', 'W', 'WA'..'WZ', 'WAA', 'WZZ'],
      uzb: ['UJ'..'UM', 'UJA'..'UMZ'],
      vat: ['HVA'..'HVZ'],
      vct: ['J8A'..'J8Z'],
      ven: ['4MA'..'4MZ', 'YV'..'YY', 'YVA'..'YYZ'],
      vnm: ['3WA'..'3WZ', 'XV', 'XVA'..'XVZ'],
      vut: ['YJ', 'YJA'..'YJZ'],
      yem: ['7OA'..'7OZ'],
      zaf: ['S8A'..'S8Z', 'ZR'..'ZU', 'ZRA'..'ZUZ'],
      zmb: ['9IA'..'9JZ'],
      zwe: ['Z2A'..'Z2Z']
    }
    PREFIXES_BY_ORGANIZATION = {
      icao: ['4YA'..'4YZ'],
      uno: ['4UA'..'4UZ'],
      wmo: ['C7A'..'C7Z']
    }

    PREFIXES_BY_COUNTRY.each_pair do |key, value|
      data = { iso_3166_alpha_3: key.to_s }
      value.each do |prefix_range|
        if prefix_range.is_a?(Range)
          prefix_range.each do |prefix|
            PREFIXES[prefix] = data
          end
        else
          PREFIXES[prefix_range] = data
        end
      end
    end

    def initialize(prefix='')
      identity = identify(prefix)
      puts identity

      if identity.is_a? Hash
        @country = ISO3166::Country.find_country_by_alpha3(identity[:iso_3166_alpha_3])
        @prefix  = prefix
        @valid   = true
      else
        @country = nil
        @prefix  = prefix
        @valid   = false
      end
    end
    
    def identify(prefix)
      PREFIXES[prefix]
    end

    def self.parse(prefix)
      self.new(prefix)
    end

  end
end
