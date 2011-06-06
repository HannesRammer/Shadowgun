class CreateAbilities < ActiveRecord::Migration
  def self.up
    create_table :abilities do |t|
      t.column :name,    :string
      t.column :text,    :text
      t.timestamps
    end

    abilities=[["ERSTE HILFE",
                "Bei einfachen Verletzungen, Vergiftungen oder Erkrankungen verhindert die Kenntnis Erste Hilfe Schlimmeres: Es können Wunden gesäubert und verbunden, Giftwirkungen verlang­samt und die Symptome von Krankheiten oder Versporung gemildert werden. Detaillierte Regeln zur Ersten Hilfe finden Sie auf Seite 254.
Mögliche Spezialisierungen: Wunden, Krankheiten, Gift, Versporung"],
               ["GEISTESKUNDE",
                "Den menschlichen Geist zu verstehen und zu manipulieren macht die Kenntnis Geisteskunde aus.
Mögliche Spezialisierungen: Psychosen, Ängste, Propagan­da, Sporenfolgen"],
               ["KRAFTLEHRE",
                "Häuser stehen nicht von allein, Maschinen funktionieren nicht, ohne dass sie nach gewissen Grundsätzen konstruiert wurden – Fortschritt und Wiederaufbau sind nur möglich, wenn man von der Lehre der Kräfte weiß.
Die Kenntnis Kraftlehre kommt zum Einsatz, wenn es um physikalische Gesetze geht und ihre Auswirkungen auf die Realität abgeschätzt werden müssen.
Mögliche Spezialisierungen: Konstruktion, Mechanik, Elektrik"],
               ["LEBENSKUNDE",
                "Lebenskunde entspricht der urvölkischen Biologie und vermit­telt Wissen über irdische Lebensformen und makro- und mi­kroskopische Vorgänge in ihnen. Wer Fäulnis und Primer und ihre Auswirkungen auf Flora und Fauna verstehen will, sollte sich der Lebenskunde widmen. Kenne deinen Feind.
Mögliche Spezialisierungen: Flora, Fauna, Primer, Homo Sapiens, Homo Degenesis, Paläontologie"],
               ["LEGENDENKENNTNIS",
                "Die Grundlagen der Welt von heute wurden in der Vergangen­heit geschaffen. Sie zu kennen gleicht einem Blick hinter die Kulissen und macht die Angst der Spitalier vor Keimen oder auch den Hass der Africaner auf den weißen Mann verständ­lich. Nur die Kurzsichtigen schimpfen Sagen und Legenden unbedeutende Märchen, die Klügeren hören interessiert zu und suchen die Wahrheit zwischen den Zeilen.
Die Kenntnis Legendenkenntnis wird angewandt, um auf Wissen, Erzählungen und Gerüchte aus der Vergangenheit zugreifen zu können.
Mögliche Spezialisierungen: Geschichtenerzähler, Kultur­geschichte (jede Kultur als eigene Spezialisierung), Kultge­schichte (jeder Kult als eigene Spezialisierung), Urvolk"],
               ["MEDIZIN",
                "Wo ein Druckverband die Blutung nicht mehr stoppt und der Kräutertee die Krankheit nicht vertreibt, muss jemand her, der ein tiefergehendes medizinisches Verständnis vom Menschen hat: Ein Arzt. Je nach Kenntnisstand können Me­diziner schwere Krankheiten kurieren, Vergiftungen stoppen, Versporung neutralisieren und traumatischen Schaden heilen. Je schwerwiegender die Erkrankung ist, umso höher fällt die Erschwernis auf den Medizin-Wurf aus.
Mögliche Spezialisierungen: Wunden, Krankheiten (Her­stellung von Medikamenten), Gift, Versporung, Chirurg, Veterinärmedizin"],
               ["MILITÄRTAKTIK",
                "Wer einen Trupp ins Feld führt, muss wissen, wie man seine Leute motiviert und mit Pathos und Versprechen auf Kampf trimmt. Das ist der erste Schritt zum Sieg. Doch es folgen noch weitere: Wo soll die Einheit einen Hinterhalt legen, und wo könnte der Feind lauern? Sturmangriff, Flankenschutz, Unterstützungsfeuer – alles Begriffe der Kriegsführung, die jemandem mit der Kenntnis Militärtaktik vertraut sind.
Mögliche Spezialisierungen: urbane Kriegsführung, Gueril­lataktik, Belagerung"],
               ["ORTSKUNDE",
                "Steppen, die sich bis zum Horizont erstrecken; Eis- und Stein­wüsten folgen auf das bunte Geflecht der Tundra, Felsnadeln ragen in der Ferne in die Höhe – im fünften nacheshato­logischen Jahrhundert von Siedlung zu Siedlung zu reisen ist ein Abenteuer. Die alten Teer-Trassen enden im Nichts, abgeknickte Schilder haben keine Bedeutung mehr für die schriftunkundige Bevölkerung. Nur wer sich auskennt, findet den rechten Weg, kann die Strecke kurz und den Verbrauch von Nahrung gering halten. Und er kann gefährliche Regionen umgehen. Die Kenntnis Ortskunde wird angewandt, wenn man sich orientieren muss oder Karten und Wegbeschreibun­gen interpretieren will.
Mögliche Spezialisierungen: Überlandreisen, Karten zeich­nen, Justitian, Tripol"],
               ["RECHTSPRECHUNG",
                "Den Wilden das Gesetz zu bringen ist ein schwieriges Unter­fangen. Es bedarf klarer Vorschriften. Die Unwissenden müs­sen erkennen, dass selbst die Richter an Regeln gebunden sind, dass das Recht zuverlässig und berechenbar ist. Die Kenntnis Rechtsprechung lässt die zugrunde liegenden Prinzipien der Welt der Paragraphen erkennen.
Mögliche Spezialisierungen: Der justitianische Kodex, tripolitanisches Handelsgesetz, jehammedanisches Büßertum, Wiedertäufer-Charta, Sippenrecht, das Wort des Raben (apo­kalyptisches Recht), Militärrecht"],
               ["SCHRIFTSPRACHE",
                "Das geschriebene Wort hat an Bedeutung verloren. Lesen und Schreiben gehören nicht länger zum Allgemeinwissen, Bücher sind kostbar und selten. Fabeln und Legenden wer­den mündlich überliefert. Und doch ist die Schriftsprache nicht gänzlich vergessen worden: Kulte wie die Spitalier und Chronisten sind abhängig von ihren Bibliotheken, gewaltige Mengen an Information wollen gebändigt werden.
Mit der Kenntnis Schriftsprache können Texte gele­sen und angefertigt werden.
Mögliche Spezialisierungen: Poesie, Alte Schrift­zeichen"],
               ["SPRACHEN",
                "Die sieben Kulturen haben über die Jahrhunderte eigene Sprachen und Dialekte entwickelt, oftmals ein Potpourri der ehemals in der Region üblichen Mundarten.
Die Kenntnis bestimmt das allgemeine Sprachverständ­nis; um eine Sprache wirklich zu beherrschen muss diese als Spezialisierung erworben werden. Jeder Charakter be­herrscht diese Kenntnis automatisch auf Stufe 4. Außerdem darf er sich eine Spezialisierung auf Stufe 2 vermerken. Diese sollte der Sprache seiner Heimatkultur entsprechen.
Mögliche Spezialisierungen: Borcisch (Deutsch mit fran­zösischen und englischen Einflüssen und vereinfachter Gram­matik), Frankisch (gut erhaltenes Französisch), Africanisch (Hocharabisch mit einzelnen französischen Wörtern gespickt), Pollnisch (eine Mixtur aus Polnisch und Russisch), Balkha­nisch (ein Amalgam russischer und balkanischer Dialekte), Purgisch (Italienisch, stark verwässert mit Borcisch), Hybrispanisch (Spanisch mit geringem balkhani­schen Einfluss), Alte Sprachen"],
               ["STOFFLEHRE",
                "Die Lehre von den Stoffen ist ein gefährliches Gebiet, denn vieles was verloren ging, muss erst durch Versuche wieder erarbeitet werden. Explosive Versuche. Was kann man vermischen, was besser nicht, was liefert kostbare Energie? Die Kenntnis Stofflehre hilft, alte Rezepturen zu nutzen, Medikamente und Explosivstoffe zu mi­schen und neue Stoffverbindungen zu erforschen.
Mögliche Spezialisierungen: Sprengstoffe, Treibstoffe, Medikamente und Drogen"],
               ["TECHNIK",
                "Ob man die Technik des Urvolks verstehen und an­wenden oder auf den Ruinen des Vergangenen etwas Neues erschaffen will – eines ist als Grundlage einer Zivilisation unerlässlich: das Verständnis für technische Abläufe.
Mit der Technik-Kenntnis werden Pläne von mechani­schen und elektrischen Gerätschaften verstehbar und können selber angefertigt werden. Generatoren, Pumpen und Moto­
ren sind einem Techniker kein Geheimnis mehr. Die Kenntnis ist allerdings rein theoretischer Natur: Um ein entsprechendes Gerät zu reparieren oder zusammenzuschrauben bedarf es der Kenntnis Beweglichkeit+Basteln.
Mögliche Spezialisierungen: Rüstungen, Nahkampfwaf­fen, Feuerwaffen, Munition, Artefakttechnik, Fahrzeuge, Computer, Maschinen, Technische Zeichnungen, Mechanik, Elektronik"],
               ["ÜBERLEBEN",
                "Große Regionen der sieben Kulturkreise werden von rauer Wildnis und Ödland dominiert. Hier zu überleben erfordert Er­fahrung im Umgang mit der Natur und einen gesunden Instinkt. Was ist essbar, wo finde ich Zuflucht? Hält das Wetter, oder steht einer der lebensgefährlichen Staubstürme an? Fragen, die mit der Kenntnis Überleben beantwortet werden können.
Mögliche Spezialisierungen: Fallen stellen, Jagen und Fi­schen, Sammeln, Spuren lesen, Wetter"],
               ["ZAHLENKUNDE",
                "Wer so weit zählen kann, um nicht bei jedem Geschäft über den Tisch gezogen zu werden, ist klar im Vorteil. Das kann längst nicht jeder von sich behaupten. Die Neolibyer und Chronisten sind die letzten wahrhaft Kundigen und sehen die Zahlenkunde mit als Grund für ihren Erfolg.
Die Kenntnis wird angewandt, wenn es um Rechenvorgän­ge und mathematisches Wissen geht – und wenn ein Händler seine Tricks durchzieht.
Mögliche Spezialisierungen: Handelsbilanzen, Höhere Ma­thematik, Zahlentricks"],
               ["AUSDAUER",
                "Eine ordentliche Fitness ist für jede Form der körperlichen Aktivität unverzichtbar. Im KatharSys ergeben sich aus der Summe von Körper und Ausdauer die Aktionspunkte.
Mögliche Spezialisierungen: Marathon, Tauchen (Luft anhalten)"],
               ["HÄRTE",
                "Im rauen Ödland oder in den dunklen Gassen der weniger kultivierten Siedlungen sind Nehmerqualitäten gefragt; hin­ter jeder Ecke können Halsabschneider oder Absonderliche lauern. Mit der Kenntnis Härte ist man nicht gefeit vor ihren Angriffen, aber man hält mehr aus und bekommt vielleicht die Chance auf einen Gegenschlag oder Zeit für die Flucht.
Über die Härte wird ermittelt, wie viele Fleischwunden man einstecken kann und wie viel Traumaschaden man erträgt.
Mögliche Spezialisierungen: Schmerzresistenz"],
               ["KLETTERN",
                "Klettern kommt zum Einsatz, wenn Abhänge oder Ruinen erklommen werden müssen.
Mögliche Spezialisierungen: Spezialisierung auf bestimmte Werkzeugtypen, Ruinenkletterer, Bergsteiger"],
               ["KRAFT",
                "Um den Körper zu stählen braucht es Schweiß und Disziplin. Belohnt wird man mit Schlagkraft und breiten Schultern, auf die viel geladen werden kann.
Die Kenntnis Kraft wirkt sich auf den Schaden bei Nah­kampfangriffen und die Maximallast aus.
Mögliche Spezialisierungen: Packesel, Gewichte stemmen, Aufbrechen"],
               ["LAUFEN",
                "Das Leben ist ein langer Lauf über steiniges Gelände. Und manchmal ist ein langer Lauf auch die einzige Möglichkeit zu überleben.
Beweglichkeit+Laufen bestimmt die Höchstzahl an Metern, die man in einer Kampfrunde überbrücken kann.
Mögliche Spezialisierungen: Unebenes Terrain"],
               ["REITEN",
                "Reittiere sind eine gebräuchliche Form der Fortbewegung im neuen Europa.
Die Kenntnis Reiten kommt zum Einsatz, wenn man unter erschwerten Bedingungen das Reittier unter Kontrolle halten und sich vor einem Sturz bewahren will.
Mögliche Spezialisierungen: Verschiedene Tierarten, Per­sönliches Tier"],
               ["SCHWIMMEN",
                "Sumpfiges Franka, gefrorenes Borca, das Mittelmeer eine fau­lige Brühe – die meisten Gewässer der bekannten Welt laden nicht gerade zum Schwimmen ein. Wenn es aber doch einmal nötig ist, sollte man wissen, wie man sich über Wasser hält. Das vermittelt einem diese Kenntnis.
Mögliche Spezialisierungen: Tauchen, Schnellschwimmen"],
               ["BASTELN",
                "Sei es ein Techniker in einer Schrotterhalle, der ein Artefakt repariert, oder ein Wiedertäufer, der für sein Dorf die Was­serpumpe wieder in Gang bringen will: Mit der Theorie alleine bekommt er das Relikt nicht in Gang. Es bedarf geschickter Hände, die darauf trainiert sind, Technik zu zerlegen und zu­sammenzufügen. Dafür steht die Kenntnis Basteln. Allerdings er­langt man mit ihr nicht automatisch das theoretische Wissen, denn das ist an die Kenntnis Verstand+Technik gebunden.
Mögliche Spezialisierungen: Rüstungen, Nahkampfwaffen, Feuerwaffen, Munition, Artefakttechnik, Fahrzeuge, Maschinen"],
               ["BEWAFFNETER NAHKAMPF",
                "Sei es eine pollnische Steinaxt, ein frankisches Langschwert oder ein Krummsäbel der Jehammedaner, Nahkampfwaffen machen den Großteil der nacheshatologischen Waffen aus.
Die Kenntnis Bewaffneter Nahkampf ermöglicht den kom­petenten Umgang mit Nahkampfwaffen aller Art.
Mögliche Spezialisierungen: Zweihändiger Kampf, Per­sönliche Waffe, Waffentypen (Spezialisierung auf einen Waf­fentyp)"],
               ["FEUERWAFFEN",
                "Für die Hellvetiker eine Selbstverständlichkeit, für Pollner seltene Artefakte: Feuerwaffen wie Gewehre und Pistolen. Mit der Kenntnis Feuerwaffen lernt man sie zu beherrschen.
Mögliche Spezialisierungen: Schnellziehen, Persönliche Waffe, Scharfschütze, Waffentypen (Spezialisierung auf einen Waffentyp)"],
               ["FLUGMASCHINEN",
                "Fluggeräte sind mit dem Urvolk ausgestorben. Ihre stählernen Skelette verrosten auf den überwucherten Pisten und in zuge­wachsenen Kratern. Doch sollte sich eines von ihnen – oder ein Nachbau – finden, so wird es jemand mit der Kenntnis Flugmaschinen steuern können.
Mögliche Spezialisierungen: verschiedene Typen von Flug­maschinen (Luftschiffe, Gleiter, etc.), Persönliches Gerät"],
               ["INITIATIVE",
                "Wer den ersten Schlag führt, der ist dem Sieg näher als der Getroffene. Kämpfer, die das beherzigen, tun gut daran, an ih­rer Initiative zu arbeiten. Ansonsten haben sie im Gefecht das Nachsehen und sollten sich daran gewöhnen, in die Defensive gedrängt zu werden.
Mögliche Spezialisierungen: Schnellziehen"],
               ["LANDFAHRZEUGE",
                "Zu den Landfahrzeugen zählen die einfachen Planwagen der Pollner, die Motorräder der Apokalyptiker als auch die Bug­gies der Geißler. Alles auf Rädern oder Ketten kann mit der Kenntnis Landfahrzeuge gesteuert werden.
Mögliche Spezialisierungen: verschiedene Fahrzeugtypen, Gelände, Persönliches Gefährt, Rennen"],
               ["PROJEKTILWAFFEN",
                "Viel älter als Feuerwaffen, bewährt und allgemein bekannt sind Fernkampfwaffen wie Bögen und Armbrüste. Mit der Kenntnis Projektilwaffen beherrscht man Sehnenwaffen jeg­licher Art.
Mögliche Spezialisierungen: Persönliche Waffe, Scharf­schütze, Waffentypen (Spezialisierung auf einen Waffentyp)"],
               ["SCHWEREWAFFEN",
                "Unter die schweren Waffen fallen vorwiegend Unterstützungs­waffen wie schwere Maschinengewehre, Mörser, Flakgeschüt­ze, Raketen- und Granatwerfer. Aber auch die Brenner der Wiedertäufer zählen zu dieser Kategorie. Mit der Kenntnis können solche Waffen gezielt eingesetzt, sowie Geschütztür­me bedient werden.
Mögliche Spezialisierungen: Persönliche Waffe, Schnellla­der, Geschütze, Richtschütze, Waffentypen (Spezialisierung auf einen Waffentyp)"],
               ["STEHLEN",
                "Mit der Kenntnis Stehlen stiehlt man dem Richter den Schlüs­sel vom Gürtel, ohne dass er etwas merkt. Oder lässt auf dem Markt etwas mitgehen.
Mögliche Spezialisierungen: Taschendiebstahl"],
               ["UNBEWAFFNETER NAHKAMPF",
                "Waffen kann man verlieren, die Fäuste hat man immer dabei. Blitzschnelle Schläge, geschickte Würfe und kraftvolle Tritte, das ist die Sprache, die Kämpfer sprechen, deren Körper zur Waffe ausgebildet wurde. Mit der Kenntnis Unbewaffneter Nahkampf wird der Kampf ohne Waffen möglich. Und ef­fizient.
Mögliche Spezialisierungen: Kampfsportarten (Spezialisie­rung auf eine Kampfart), Entwaffnen, Würfe, Blocken"],
               ["VERBERGEN",
                "Die Welt steckt voller Gefahren. Manchmal kann es sehr nütz­lich sein, sich einfach vor ihnen zu verbergen. Und zwar mit dieser Kenntnis.
Mögliche Spezialisierungen: Verkleiden, Im Schutze der Nacht (sich die Dunkelheit zu Nutze machen), Naturkind (draußen verbergen)"],
               ["WASSERFAHRZEUGE",
                "Die riesigen Transportschiffe der Neolibyer beherrschen das Mittelmeer. Mit der Kenntnis Wasserfahrzeuge können diese gigantischen Stahlpötte sicher in den Hafen gebracht, aber auch kleinere Boote durch Untiefen gesteuert werden.
Mögliche Spezialisierungen: verschiedene Wasserfahrzeu­ge, Persönliches Gerät"],
               ["WURFWAFFEN",
                "Manch einer nennt es Fernkampf auf niedrigstem Niveaum, aber auch ein geschleudertes Messer kann ebenso tödlich sein wie ein gezielter Schwerthieb.
Mit der Kenntnis Wurfwaffen lernt man Steinschleudern zu beherrschen; Speere, Messer, Steine und Granaten finden jetzt ihren Weg ins Ziel.
Mögliche Spezialisierungen: Persönliche Waffe, Waffenty­pen (Spezialisierung auf einen Waffentyp)"],
               ["DOMINIEREN",
                "Versucht man, seine Gegenüber zu dominieren, so haben die rationalen Argumente ausgespielt. Es ist eine Form der psychischen Gewalt, die den Willen des Opfers bricht und es dem Täter ausliefert. Emotionen wie Angst oder Lust sind die Werkzeuge des Dominierens.
Mögliche Spezialisierungen: Verhören"],
               ["FÜHRUNG",
                "Er ist der Hirte, das Volk seine Herde: Wer eine kleine Einheit in den Kampf oder ein Volk in eine ungewisse Zukunft führen will, benötigt die Kenntnis Führung. Mir ihr kann man Men­schen für seine Sache begeistern, pathetische Reden halten und selbstsicher wirken, auch wenn man von ihrem Untergang überzeugt ist.
Mögliche Spezialisierungen: Militärische Führung, Zivile Führung"],
               ["UMGANG",
                "Viele Kulturen und Kulte tummeln sich auf der Landkarte, mit ihren eigenen Ansichten und Zielen. Es ist nicht leicht, zwischen den Welten zu spazieren und stets das richtige Wort zu treffen. Was einem hier Tür und Tor öffnet, gilt bei den Nachbarn als Affront. Mit der Kenntnis Umgang weiß man um die Eigenarten der Kulturkreise, wirft der Hagaritin keinen begehrlichen Blick zu und pinkelt auch nicht vor die Richthalle Justitians. Außer man sucht die Gefahr.
Mögliche Spezialisierungen: Diplomatie"],
               ["VERFÜHREN",
                "Das alte Spiel der Geschlechter ist in den Augen der Apo­kalyptiker eine Kunst, von der sie gut leben können. Mit der Kenntnis Verführen tut man es ihnen gleich und gewinnt Seele und Körper des Gegenübers mit aufreizender Kleidung, Schmeicheleien und betörenden Düften.
Mögliche Spezialisierungen: Mit den Augen sprechen, Tanzen"],
               ["VERHANDELN",
                "Krieg oder Frieden, Freiheit oder Abhängigkeit, Gewinn oder Verlust – alles Verhandlungssache. Die eigenen Interessen zu wahren ist ein stetiger Kampf, den man im günstigsten Fall durch Worte und die Kenntnis Verhandeln für sich entschei­det.
Mögliche Spezialisierungen: Feilschen, Rhetorik"],
               ["EMPATHIE",
                "Was würde man dafür geben, die Gedanken seines Gegenübers zu kennen? Was will der andere wirklich, wie denkt er über mich? Wo liegen seine Stärken und Schwächen? Hat er Angst? Fühlt er sich überlegen? Die Signale des Körpers liegen einem Menschen mit der Kenntnis Empathie offen; nur ein guter Schauspieler kann einen Empathen noch in die Irre führen.
Will man die Reaktion von Tieren abschätzen oder eine Be­ziehung zu ihnen aufbauen, so hilft auch hier Empathie.
Mögliche Spezialisierungen: Tierverständnis, Spezialisie­rung auf einen bestimmten Kult"],
               ["GLAUBEN",
                "Glauben ist die Zuflucht für die Seele, sei es der Glauben an die Neognosis der Wiedertäufer oder an die Verheißung des Jehammeds. Die Kenntnis Glauben ist immer etwas sehr Persönliches und nur auf die eigene Religion anzuwenden, sie vermittelt kein Wissen über andere Glaubensgemeinschaften. In manchen Situationen, wenn Unmenschliches geleistet wer­den soll oder der Geist sich vor Grauen verschließt, kann der Glauben einen Ausweg bieten: Der Spieler darf beispielsweise statt eines geforderten Wurfs auf Selbstbeherrschung auf Glauben würfeln.
Mögliche Spezialisierungen: Fanatismus"],
               ["GLÜCKSSPIEL",
                "Die Apokalyptiker haben es gemeistert, beliebt ist es überall: Das Glücksspiel. Mit dieser Kenntnis hat man das richtige Gefühl für diese Art von Spielen – und das Schicksal verbeugt sich vor einem.
Mögliche Spezialisierungen: Falschspiel (Karten, Brett etc.)"],
               ["MUSIZIEREN",
                "Musik ist ein Bestandteil jeder Kultur, ist ein Spiegel ihrer Bedürfnisse und Träume. Mit der Kenntnis Musizieren erlangt man ein Grundverständnis dafür, kann singen und Instrumen­te spielen.
Mögliche Spezialisierungen: Persönliches Instrument, Mu­sikart, Singen, Komponieren"],
               ["SELBSTBEHERRSCHUNG",
                "Mit der Kenntnis Selbstbeherrschung behält man in brenzligen Situationen einen klaren Kopf und übersteht Stresssituationen mit Würde. Mit Selbstbeherrschung hält man außerdem den drohenden Wahn durch Versporung auf Abstand.
Mögliche Spezialisierungen: Sporenresistenz, Stress"],
               ["VERSTELLEN",
                "Rollen spielen, andere in die Irre führen, ob zur Unterhaltung, als Selbstschutz oder Lebenseinstellung – jeder trägt eine Mas­ke, hinter der er sein wahres Ich verbirgt. Mit der Kenntnis Verstellen vermag man, diese Maske gegen eine beliebige aus­zutauschen und trotzdem glaubwürdig zu scheinen.
Mögliche Spezialisierungen: Schauspielerei, Nachahmung (für jeden Kult einzeln; Nachahmung: Spitalier würde einem Charakter erlauben, die Rolle eines Arztes zu spielen)"],
               ["WAHRNEHMUNG",
                "Ein wertvolles Artefakt im Meer aus Staub, das Glitzern einer Fernrohrlinse in der Ferne oder der schattenhafte Schemen im Augenwinkel – sie rechtzeitig zu entdecken ist unbezahlbar. Die Wahrnehmung zu trainieren heißt den Überblick zu be­halten.
Mögliche Spezialisierungen: Lauschen, Wittern, Tastsinn, Adlerauge "]]

    abilities.each do |ability|
      ab = Ability.new()
      ab.name = ability[0]
      ab.text = ability[1]
      ab.save
    end
  end

  def self.down
    drop_table :abilities
  end
end
