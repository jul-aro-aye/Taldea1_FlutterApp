import '../ereduak/jokalari_erronka.dart';

String avatarUrlLortu(String izena) {
  final encodedName = Uri.encodeComponent(izena);
  return 'https://ui-avatars.com/api/?name=$encodedName&size=512&background=0A7F3F&color=ffffff&bold=true';
}

const List<JokalariErronka> jokalariErronkak = [
  JokalariErronka(
    izena: 'Lionel Messi',
    herrialdea: 'Argentina',
    posizioa: 'Aurrelaria',
    ezaugarria: 'Dribbling aparta',
    deskribapena:
        'Lionel Messi futbolaren historian jokalari teknikoenetako bat da. '
        'Baloiaren kontrola, pase fina eta area inguruko erabaki azkarrak dira bere ezaugarri nagusiak.',
    datuak: [
      'Rosarion jaio zen eta oso gaztetatik nabarmendu zen talentuagatik.',
      'Ezker hankarekin jokaldi ikusgarriak egiten ditu maiz.',
      'Argentinako selekzioarekin txapelketa handiak irabazi ditu.',
    ],
    galdera:
        'Testuaren arabera, zein multzok laburbiltzen ditu ondoen Messiren ezaugarri nagusiak?',
    aukerak: [
      'Buruzko jokoa, defentsa-lana eta markaje estua',
      'Indar fisikoa, sake luzeak eta geldikako jaurtiketa bortitzak',
      'Baloiaren kontrola, pase fina eta area inguruko erabaki azkarrak',
      'Atezain erreflexuak, area irteerak eta blokeoak',
    ],
    erantzunZuzena:
        'Baloiaren kontrola, pase fina eta area inguruko erabaki azkarrak',
  ),
  JokalariErronka(
    izena: 'Cristiano Ronaldo',
    herrialdea: 'Portugal',
    posizioa: 'Aurrelari hegalekoa',
    ezaugarria: 'Erremate indartsua',
    deskribapena:
        'Cristiano Ronaldo goleatzaile handia da, aireko jokoan eta errematean oso indartsua. '
        'Bere diziplina fisikoa eta lehiakortasuna mundu osoan ezagunak dira.',
    datuak: [
      'Madeiran jaio zen eta gaztetatik erakutsi zuen potentzia handia.',
      'Bi hankekin and buruz arrisku handia sortzen du.',
      'Gol ugari sartu ditu klub and selekzio mailan.',
    ],
    galdera:
        'Irakurri duzun deskribapenaren arabera, zertan nabarmentzen da bereziki Cristiano Ronaldo?',
    aukerak: [
      'Aireko jokoan and errematean',
      'Jokoaren tempoa kontrolatzen',
      'Atezainaren aurreko geldikako irteeretan',
      'Atzeko lerroko antolaketan',
    ],
    erantzunZuzena: 'Aireko jokoan and errematean',
  ),
  JokalariErronka(
    izena: 'Luka Modric',
    herrialdea: 'Kroazia',
    posizioa: 'Erdilaria',
    ezaugarria: 'Jokoaren erritmoa',
    deskribapena:
        'Luka Modric erdiko lerroko maisua da. Jokoaren tempoa kontrolatzen du, pase zehatzak ematen ditu '
        'eta taldearen oreka bilatzen du etengabe.',
    datuak: [
      'Erdiko zelaian ikuspegi aparta du.',
      'Pase motzak and luzeak zehaztasun handiz erabiltzen ditu.',
      'Bere selekzioarekin txapelketa handietan paper garrantzitsua izan du.',
    ],
    galdera:
        'Zein da Modrici buruz agertzen den ideia taktiko nagusia?',
    aukerak: [
      'Atezainari babesa emateko area txikian kokatzen da etengabe',
      'Jokoaren tempoa kontrolatzen du eta taldearen oreka bilatzen du',
      'Hegaleko esprinter hutsa da eta ia ez du erdirik erabiltzen',
      'Marka pertsonalak egiten ditu eta oso gutxitan pasatzen du baloia',
    ],
    erantzunZuzena:
        'Jokoaren tempoa kontrolatzen du eta taldearen oreka bilatzen du',
  ),
  JokalariErronka(
    izena: 'Andres Iniesta',
    herrialdea: 'Espainia',
    posizioa: 'Erdilaria',
    ezaugarria: 'Pase fina',
    deskribapena:
        'Andres Iniesta espazio txikietan oso eraginkorra izan zen. Baloiaren kontrol lasaia eta '
        'une erabakigarrietan agertzeko gaitasuna zituen.',
    datuak: [
      'Erdiko zelaian teknikoki oso garbia zen.',
      'Partida handietan jokaldi erabakigarriak utzi zituen.',
      'Talde-jokoan and pasean aparteko ulermena zuen.',
    ],
    galdera:
        'Deskribapenari erreparatuta, zein testuingurutan azaltzen da bereziki eraginkor Andres Iniesta?',
    aukerak: [
      'Aireko dueluan and indar fisikoko norgehiagoketan',
      'Atezainarekin bat-bateko irteeretan and eskuekin',
      'Defentsa-lerroan atzera eginda markaje zuzenean',
      'Espazio txikietan and une erabakigarrietan',
    ],
    erantzunZuzena: 'Espazio txikietan and une erabakigarrietan',
  ),
  JokalariErronka(
    izena: 'Erling Haaland',
    herrialdea: 'Norvegia',
    posizioa: 'Aurrelaria',
    ezaugarria: 'Abiadura eta indarra',
    deskribapena:
        'Erling Haaland aurrelari indartsua da, espazioan korrika egiteko eta aukera gutxirekin gola egiteko '
        'gaitasun handia duena.',
    datuak: [
      'Defentsaren bizkarrean arrisku handia sortzen du.',
      'Bere gorputz indarraz baliatzen da duelotan nagusitzeko.',
      'Area barruan oso errematatzaile fidagarria da.',
    ],
    galdera:
        'Haalanden fitxaren arabera, zein egoeratan bihurtzen da bereziki arriskutsu?',
    aukerak: [
      'Espazioan korrika egin and aukera gutxirekin gola egiteko uneetan',
      'Erdiko zelaian pase laburrak soilik lotzen dituenean',
      'Aurkariaren sakeak eskuarekin mozten dituenean',
      'Atzeko lerroan presiorik gabe baloia ateratzen duenean',
    ],
    erantzunZuzena:
        'Espazioan korrika egin and aukera gutxirekin gola egiteko uneetan',
  ),
  JokalariErronka(
    izena: 'Kylian Mbappe',
    herrialdea: 'Frantzia',
    posizioa: 'Aurrelari hegalekoa',
    ezaugarria: 'Abiadura ikusgarria',
    deskribapena:
        'Kylian Mbappe oso jokalari azkarra da, metro gutxitan abiadura handia hartzen duena. '
        'Zelaian espazioa aurkitzen duenean oso arriskutsua bihurtzen da.',
    datuak: [
      'Aurkariari bizkarra irabazteko gaitasun aparta du.',
      'Hegaletik zein erdian jokatu dezake.',
      'Trantsizio azkarretan bereziki nabarmentzen da.',
    ],
    galdera:
        'Irakurri duzun informazioan, noiz esaten da Mbappe bereziki arriskutsu bihurtzen dela?',
    aukerak: [
      'Area barruan geldirik geratzen denean',
      'Zelaian espazioa aurkitzen duenean',
      'Defentsa lerroan atzera sartzen denean',
      'Buruz soilik errematatzeko prestatzen denean',
    ],
    erantzunZuzena: 'Zelaian espazioa aurkitzen duenean',
  ),
  JokalariErronka(
    izena: 'Neymar Jr',
    herrialdea: 'Brasil',
    posizioa: 'Aurrelari hegalekoa',
    ezaugarria: '1 kontra 1 bikaina',
    deskribapena:
        'Neymar Jr teknika, dribblinga and sormena uztartzen dituen jokalaria da. '
        'Zelaiko azken herenean desoreka handia sor dezake.',
    datuak: [
      'Baloiaren kontrol oso finarekin nabarmentzen da.',
      'Zaleek asko miresten dute bere irudimenagatik.',
      'Erasoan askatasunarekin jokatu ohi du.',
    ],
    galdera:
        'Zein hirukote aipatzen da Neymar Jr-ren profila azaltzeko?',
    aukerak: [
      'Buruzko jokoa, markajea and blokeoak',
      'Atezain jokoa, esku luzaketak and erreflexuak',
      'Defentsa lerroa, baloi garbiketa and estaldurak',
      'Teknika, dribblinga and sormena',
    ],
    erantzunZuzena: 'Teknika, dribblinga and sormena',
  ),
  JokalariErronka(
    izena: 'Alexia Putellas',
    herrialdea: 'Espainia',
    posizioa: 'Erdilaria',
    ezaugarria: 'Lidergoa eta kalitatea',
    deskribapena:
        'Alexia Putellas erdiko zelaiko jokalari oso osatua da. Pasa, iritsi and jokoa ulertzeko duen gaitasunagatik '
        'nabarmendu da urte luzez.',
    datuak: [
      'Jokoaren antolaketan pisu handia du.',
      'Teknika and irakurketa taktikoa uztartzen ditu.',
      'Erasoan zein sorkuntzan eragin handia izan dezake.',
    ],
    galdera:
        'Alexia Putellasen fitxan, zein gaitasun multzo azpimarratzen da bereziki?',
    aukerak: [
      'Atezainaren pareko esku-jokoa and area kontrola',
      'Buruzko joko soila and erremate bortitza bakarrik',
      'Pasa, iritsi and jokoa ulertzeko gaitasuna',
      'Alboko marran soilik zabaldu and zentroak jartzea',
    ],
    erantzunZuzena: 'Pasa, iritsi and jokoa ulertzeko gaitasuna',
  ),
  JokalariErronka(
    izena: 'Aitana Bonmati',
    herrialdea: 'Espainia',
    posizioa: 'Erdilaria',
    ezaugarria: 'Mugimendu adimentsuak',
    deskribapena:
        'Aitana Bonmati erdilaria da, baloirik gabe oso ondo mugitzen dena and jokaldiak lotzeko gaitasun handia duena. '
        'Erritmo aldaketetan and azken pasean ere nabarmendu ohi da.',
    datuak: [
      'Zelaiko espazioak ondo interpretatzen ditu.',
      'Pase lerroak sortzen ditu etengabeko mugimenduarekin.',
      'Erdiko zelaian dinamismo handia ematen du.',
    ],
    galdera:
        'Aitana Bonmatiren deskribapenaren arabera, zerk ematen dio taldeari dinamismo handia?',
    aukerak: [
      'Baloirik gabe ondo mugitzeak and pase lerroak sortzeak',
      'Atezain moduan area txikia kontrolatzeak',
      'Defentsa lerroan geldi mantentzeak and arriskurik ez hartzeak',
      'Hegal batean geldirik egoteak and apenas mugitzeak',
    ],
    erantzunZuzena: 'Baloirik gabe ondo mugitzeak and pase lerroak sortzeak',
  ),
  JokalariErronka(
    izena: 'Zinedine Zidane',
    herrialdea: 'Frantzia',
    posizioa: 'Erdilaria',
    ezaugarria: 'Kontrola eta dotorezia',
    deskribapena:
        'Zinedine Zidane futbolaren historiako erdilaririk dotoreenetakoa izan zen. '
        'Lehen ukitua, gorputz orientazioa and pasearen kalitatea ziren bere ezaugarri nagusiak.',
    datuak: [
      'Baloiaren gaineko kontrol aparta zuen.',
      'Partida handietan erabakigarri agertzeko gaitasuna zuen.',
      'Bere joko estiloa lasaitasunarekin and kalitatearekin lotzen da.',
    ],
    galdera:
        'Zidaneren fitxan, zein ezaugarri tekniko ageri dira bereziki nabarmenduta?',
    aukerak: [
      'Esku bidezko blokeoak, airerako irteerak and sake luzeak',
      'Lehen ukitua, gorputz orientazioa and pasearen kalitatea',
      'Markaje itsaskorra, sarrera bortitzak and baloi garbiketa',
      'Abiadura hutsa, zentro itxiak and alboko sakeak',
    ],
    erantzunZuzena: 'Lehen ukitua, gorputz orientazioa and pasearen kalitatea',
  ),
];
