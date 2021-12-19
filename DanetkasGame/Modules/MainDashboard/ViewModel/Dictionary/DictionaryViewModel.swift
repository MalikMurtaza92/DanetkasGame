//
//  DictionaryViewModel.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 27/08/2021.
//

import Foundation


struct DictionaryViewModel {
    
    var words: [Dictionary] = []
    
    init() {
        words = [Dictionary(word: "Accompanist", meaning: "a person who provides a musical accompaniment to another instrumentalist or to a singer.", isSelected: false),
                 Dictionary(word: "Arrangement", meaning: "new version of a previously composed work, usually employing new instrumentation.", isSelected: false),
                 Dictionary(word: "Aria", meaning: "a self-contained piece for one voice, with or without instrumental accompaniment, normally part of a larger work.", isSelected: false),
                 Dictionary(word: "Bagpipes", meaning: "a musical instrument with reed pipes that produce sound resulted by the pressure of wind emitted from a bag squeezed by the player's arm. Bagpipes are associated especially with Scotland, but are also used in folk music in Ireland and France, and in varying forms across Europe and western Asia.", isSelected: false),
                 Dictionary(word: "Ballet", meaning: "an artistic dance form performed to music, using precise and highly formalized set steps and gestures. Classical ballet, which originated in Renaissance Italy and established its present form during the 19th century, is characterized by light, graceful movements and the use of pointe shoes with reinforced toes.", isSelected: false),
                 Dictionary(word: "Baritone", meaning: "an adult male singing voice between tenor and bass.", isSelected: false),
                 Dictionary(word: "Bass", meaning: "the lowest adult male singing voice.", isSelected: false),
                 Dictionary(word: "Castrato", meaning: "a male singer castrated in boyhood so as to retain a soprano or alto voice. The practice of castration was banned in 1903.", isSelected: false),
                 Dictionary(word: "Choir", meaning: "an organized group of singers, especially one that takes part in church services or performs in public.", isSelected: false),
                 Dictionary(word: "Circular breathing", meaning: "a technique of inhaling through the nose while blowing air through the lips from the cheeks, used to maintain constant exhalation, especially by players of certain wind instruments.", isSelected: false),
                 Dictionary(word: "Clarinet", meaning: "a woodwind instrument with a single-reed mouthpiece, a cylindrical tube with a flared end, and holes stopped by keys.", isSelected: false),
                 Dictionary(word: "Composer", meaning: "a person who writes music as a professional occupation.", isSelected: false),
                 Dictionary(word: "Concerto", meaning: "a musical composition for a solo leading instrument(s) accompanied by an orchestra.", isSelected: false),
                 Dictionary(word: "Conductor", meaning: "a person who directs the performance of an orchestra or choir, usually with the help of a baton (wooden stick).", isSelected: false),
                 Dictionary(word: "Contrabass (or double bass)", meaning: "the largest and lowest-pitched instrument of the strings family, providing the bassline of the orchestral string section and also used in jazz and some country music.", isSelected: false),
                 Dictionary(word: "Cymbal", meaning: "percussion instrument of indefinite pitch (a sound which doesn’t correspond to a specific musical note). O\\u001Fen used in pairs, cymbals consist of thin, normally round metal plates.", isSelected: false),
                 Dictionary(word: "Dodecaphony (or twelve-tone technique)", meaning: "In this compositional system, the same note cannot be repeated before all others are played, like this, all notes have equal importance. It consists of using all of the 12 notes in the western chromatic scale system. This new revolutionary way of composing music was developed in the XXth century.", isSelected: false),
                 Dictionary(word: "Duduk", meaning: "an ancient Armenian double reed woodwind instrument made of apricot wood. It is usually played in pairs, while one player plays the melody, another player holds a sustained low tone (dum). It has a soulful and evocative sound. It was used in the film “Gladiator” (2000), directed by Ridley Scott.", isSelected: false),
                 Dictionary(word: "Flute", meaning: "a wind instrument made from a tube with holes that are covered by the fingers or keys, held vertically or horizontally so that the player's breath strikes a narrow edge. The modern orchestral form is a transverse flute, which is held horizontally, typically made of metal, with an elaborate set of keys. (Flutist - flute player)", isSelected: false),
                 Dictionary(word: "Fantasia", meaning: "musical composition with its roots in the art of improvisation. It seldom follows the textbook rules of any strict musical form.", isSelected: false),
                 Dictionary(word: "Horn", meaning: "comes in various shapes. A tube, usually made of metal and o\\u001Fen curved in various ways, with one narrow end into which the musician blows, and a wide end from which sound emerges. (Hornist - horn player)", isSelected: false),
                 Dictionary(word: "Lute", meaning: "a plucked string instrument with a long neck bearing frets and a rounded body with a flat front, rather like a halved egg in shape. An ancestor of the modern guitar. (Lutenist - lute player)", isSelected: false),
                 Dictionary(word: "Luthier", meaning: "symbols denoting a musical sound. Several systems are used nowadays, depending on the country. English speaking countries use the note names: A-B-C-D-E-F-G, while some other countries call them: Do-Re-Mi-Fa-Sol-La-Si.", isSelected: false),
                 Dictionary(word: "Movement", meaning: "symbols denoting a musical sound. Several systems are used nowadays, depending on the country. English speaking countries use the note names: A-B-C-D-E-F-G, while some other countries call them: Do-Re-Mi-Fa-Sol-La-Si.", isSelected: false),
                 Dictionary(word: "Musical Notes", meaning: "a pedestal or elevated rack designed to hold a paper score or sheets of music in position for reading.", isSelected: false),
                 Dictionary(word: "Musicologist", meaning: "an expert in music as an academic subject, usually a non-performing musician.", isSelected: false),
                 Dictionary(word: "Note", meaning: "a symbol denoting a musical sound. Notes can represent the pitch and duration of a sound in musical notation.", isSelected: false),
                 Dictionary(word: "Opera", meaning: "a dramatic work in one or more acts, set to music for singers and instrumentalists.", isSelected: false),
                 Dictionary(word: "Orchestra", meaning: "a group of instrumentalists, one that combines string, woodwind, brass, and percussion instruments, usually playing classical music.", isSelected: false),
                 Dictionary(word: "Organ", meaning: "a large musical instrument having rows of pipes supplied with air from bellows (now usually electrically powered), and played using a keyboard or an automatic mechanism. The pipes are controlled by levers that open and close the air", isSelected: false),
                 Dictionary(word: "Piano", meaning: "a large keyboard musical instrument with a wooden case enclosing a soundboard and metal strings, which are struck by hammers when the keys are depressed. The strings' vibration is stopped by dampers when the keys are released and can be regulated for length and volume by two or three pedals.", isSelected: false),
                 Dictionary(word: "Percussion", meaning: "musical instruments played by striking with the hand or with a stick or beater, or by shaking, including drums, cymbals, xylophones, gongs, bells, and rattles. (Percussionist - percussion player)", isSelected: false),
                 Dictionary(word: "Perfect Pitch", meaning: "the ability to recognize the pitch (degree of highness or lowness) of a note or produce any given note without having an external reference.", isSelected: false),
                 Dictionary(word: "Premiere", meaning: "the debut (first public presentation) of a play, film, dance, or musical composition.", isSelected: false),
                 Dictionary(word: "Prepared Piano", meaning: "a piano with objects placed on or between the strings, or with some retuned", isSelected: false),
                 Dictionary(word: "Presto", meaning: "(From italian) in a quick tempo, fast.", isSelected: false),
                 Dictionary(word: "Quartet", meaning: "1. a musical composition for four instruments or voices. 2. a group or set of four musicians (ex. classical string quartet consists of two violinists, an violist and a cellist).", isSelected: false),
                 Dictionary(word: "Rhythm", meaning: "a strong, regular repeated pattern of movement or sound.", isSelected: false),
                 Dictionary(word: "Rehearsal", meaning: "a practice or trial performance of a play, musical concert or other work for later public performance.", isSelected: false),
                 Dictionary(word: "Sheet music/Scores", meaning: "written form of a musical composition.", isSelected: false),
                 Dictionary(word: "Soprano", meaning: "the highest singing voice, usually sung by women.", isSelected: false),
                 Dictionary(word: "String (Instruments)", meaning: "a family of musical instruments that produce sound from vibrating strings.", isSelected: false),
                 Dictionary(word: "String Quartet (Classical)", meaning: "a chamber music ensemble consisting of first and second violins, viola, and violoncello.", isSelected: false),
                 Dictionary(word: "Subito forte", meaning: "(from Italian) suddenly loud.", isSelected: false),
                 Dictionary(word: "Symphony", meaning: "an elaborate musical composition for orchestra, typically in four movements.", isSelected: false),
                 Dictionary(word: "Tempo", meaning: "the speed or pace of a given piece.", isSelected: false),
                 Dictionary(word: "Tessitura (or register)", meaning: "a particular part of the range of a voice or instrument.", isSelected: false),
                 Dictionary(word: "Theremin", meaning: "an electronic musical instrument controlled without physical contact by the player. It is named a\\u001Eer its inventor, Leon Theremin, who patented the device in 1928.", isSelected: false),
                 Dictionary(word: "Trumpet", meaning: "a brass musical instrument with a flared bell and a bright, penetrating tone.", isSelected: false),
                 Dictionary(word: "Tune(or melody)", meaning: "a brass musical instrument with a flared bell and a bright, penetrating tone.", isSelected: false),
                 Dictionary(word: "Tune(or melody)", meaning: "The main part of a musical composition. It usually has an accompaniment (secondary part).", isSelected: false),
                 Dictionary(word: "Tuning", meaning: "preparing the instrument so that when it is played it will sound at the correct pitch: not too high nor too low.", isSelected: false),
                 Dictionary(word: "Viola", meaning: "string instrument with a lower sound than the violin, but higher than the violoncello. In the past, the viola varied in size and style, as did in names. The word viola originates from the Italian language. The Italians o\\u001Een used the term: viola da braccio (“of the arm”).", isSelected: false),
                 Dictionary(word: "Violin", meaning: "a string musical instrument of high pitch, played with a horsehair bow. The classical European violin was developed in the 16th century. It has four strings and a body narrowed at the middle, with two f-shaped sound holes.", isSelected: false),
                 Dictionary(word: "Violoncello (cello)", meaning: "a bass instrument of the string family, held upright on the floor between the legs of the seated player. It o\\u001Een plays the bass part.", isSelected: false),
                 Dictionary(word: "Wind (instruments)", meaning: "a family of musical instruments that produces sound by the vibration of air. Typically the players blow into the instrument using special techniques.", isSelected: false)
        ]
    }

}
struct Dictionary {
    var word: String
    var meaning: String
    var isSelected: Bool
}

