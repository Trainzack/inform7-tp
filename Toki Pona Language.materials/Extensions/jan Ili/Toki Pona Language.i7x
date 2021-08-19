Toki Pona Language by jan Ili begins here.

The language of play is the tokipona language.

Volume 1 - Settings

[This is a single short section, of new material. Some basic choices are made
here – does the language have genders, does it have unusual tenses, and so on.]

[It's customary to define a constant so that I6 code can conditionally compile
if we're using this extension, though nothing in the I7 compiler needs it.]

Include (-
Constant LIBRARY_TOKI_PONA;       ! for dependency checking.
-)

Volume 2 - Language

[This contains the real linguistic work.]

Part 2-1 - Determiners

Chapter 2-1-1 - Articles

[There are three tasks here:
	(a) We provide equivalents to the text substitutions “[The ...]”, since it makes text much more readable for
	very little work.
	(b) We provide Preform grammar for definite and indefinite articles, and also for a few useful words like
	“ici” (French for “here”). Preform grammar is a new metalanguage inside Inform which expresses its
	syntax. This will eventually be used so that language bundles can completely replace English as the
	source text language, but that’s for the future. Preform will not be explained here: see the document
	The English Syntax of Inform for more details.
	(c) We provide the following Inform 6 constants, arrays, and routines, exactly as in past builds:
		LanguageAnimateGender
		LanguageInanimateGender
		LanguageContractionForms
		LanguageContraction
		LanguageArticles
		LanguageGNAsToArticles
]



Chapter 2-1-2 - Numbers

[We include the I6 array LanguageNumbers and routine LanguageNumber,
which have not changed, but we also do something new: we include Preform grammar for the names of the
small ordinal and cardinal numbers.]

Include (-
language tokipona

<cardinal-number-in-words> ::=
	ala |
	wan |
	tu |


<ordinal-number-in-words> ::=
	nanpa ala |
	nanpa wan |
	nanpa tu |


-) in the Preform grammar.

Include (-
Array LanguageNumbers table
	'wan' 1 'tu' 2
;
[ LanguageNumber n forbid_s ike;
	! Zero
	if (n == 0) {
		print "ala";
		rfalse;
	}

	ike = false;

	if (n < 0) {
		ike = true;
		n = -n;
	}
	
	switch (n) {
		1: print "wan";
		2: print "tu";
		default: print "mute";
	}
	
	if (ike) {
		print " ike";
	}
	
	return;

];
-) instead of "Numbers" in "Language.i6t".


Part 2-2 - Nouns

Chapter 2-2-1 - Pronouns and possessives for the player

[English Language defines the
following text substitutions:
	"[We]" or "[we]"
	"[Us]" or "[us]"
	"[Our]" or "[our]"
	"[Ours]" or "[ours]"
	"[Ourselves]" or "[ourselves]"
In this section we define equivalents. Note that the style has changed; we are trying to avoid hyphenations,
or names like Him-or-Them. (It isn’t always possible.) In Toki Pona, they come out to:
	"[sina]"
]

To say sina:
	now the prior named object is the player;
	if the story viewpoint is first person singular or the story viewpoint is first person plural:
		say "mi";
	else if the story viewpoint is second person singular or the story viewpoint is second person plural:
		say "sina";
	else:
		say "ona";
		
[TODO: Maybe check if last object is sina or mi?]
To say li:
	let the item be the prior named object;
	if the item is the player:
		if the story viewpoint is third person singular or the story viewpoint is third person plural:
			say " li";
	else:
		say " li";

Chapter 2-2-2 - Pronouns and possessives for other objects

[These are similar, but easier.
They are named from the third-person viewpoint with the same number as the adaptive text viewpoint; so
in the case of Toki Pona, we’ll go with third person singular. We define:
	[ona]
	
]

To say ona/Ona:
	let the item be the prior named object;
	if the item is the player:
		say "[sina]";
	otherwise:
		say "ona";

Chapter 2-2-3 - Directions

[Here we use a new feature of Inform:
	North translates into French as le nord.
This allows a language extension to give a French name to a kind or instance which already has an English
name: in this case, the direction “north”, which is created by the Standard Rules. The French name is the
one used in play, both for printing and for command parsing. Note the article “le”, which tells Inform the
gender and number of the name (singular, masculine). This is all much easier than writing:
	The printed name of north is ”nord”. North is male. Understand ”nord” as north.
If there are abbreviated names for directions, this is where to put them:
	Understand ”nord-est/nordest” or ”ne” as northeast.
]

North translates into tokipona as nasin lete.
South translates into TokiPona as nasin seli.
East translates into TokiPona as nasin pi open suno.
Understand "nasin pi kama suno" as nasin pi open suno.
West translates into TokiPona as nasin pi suno pini.
Northeast translates into TokiPona as nasin lete poka open suno.
Southwest translates into TokiPona as nasin seli poka suno pini.
Southeast translates into TokiPona as nasin seli poka open suno.
Northwest translates into TokiPona as nasin lete poka suno pini.
Inside translates into TokiPona as insa.
Outside translates into TokiPona as selo.
Up translates into TokiPona as sewi.
Down translates into TokiPona as anpa.



Chapter 2-2-4 - Kinds

[This is new material. We give translations of the names of all kinds of
objects created in the Standard Rules or other built-in extensions. For example,
	A player’s holdall translates into French as un fourre-tout.
Note an important change: language extensions are now expected to translate for every extension built in to
Inform, not just the Standard Rules. I’ve given each such extension a section number (2-2-5-1, and so on).
]

An object translates into TokiPona as tan ijo.
A room translates into TokiPona as tomo.
A thing translates into TokiPona as ijo.
A door translates into TokiPona as lupa.
A container translates into TokiPona as poki.
A vehicle translates into TokiPona as tomo tawa.
A player's holdall translates into TokiPona as poki sina.
A supporter translates into TokiPona as supa.
A backdrop translates into TokiPona as ijo ma.
A person translates into TokiPona as jan.
A man translates into TokiPona as mije.
A woman translates into TokiPona as meli.
An animal translates into TokiPona as soweli.
A device translates into TokiPona as ilo.
A direction translates into TokiPona as nasin.
A region translates into TokiPona as ma.


Chapter 2-2-5 - Plurals

[This is new material. We must give Inform instructions on how to form
the plural of a noun, and we do this by writing a “trie” using Preform grammar.
For more on tries, it may be helpful to see how Inform defines English inflections, since that’s a simple case.
See The English Syntax of Inform for more details.
	The circulated draft of “French Language” defines a method like so:
	(a) a list of about 25 irregular plurals, such as “pneu” to “pneus”;
	(b) a general rule based on noun endings, such as that a noun ending in “eu” normally forms a plural by
	adding “x” – for example “neveu” becomes “neveux”;
	(c) a default rule to use if none of these apply – add “s”.
	It’s important to be as thorough as possible in covering irregularities and exceptions. (The ten most commonly used verbs in English and French, for example, are all irregular; but the writer will expect them to
	work.)
]

Include (-
language tokipona


<singular-noun-to-its-plural> ::=
	*	0


-) in the Preform grammar. 

Chapter 2-2-6 - Cases

Chapter 2-2-7 - Times of day

Part 2-3 - Adjectives

Part 2-4 - Verbs

Chapter 2-4-1 - Verb conjugations

Chapter 2-4-2 - Meaningful verbs

Chapter 2-4-3 - Prepositions

Volume 3 - Responses

Part 3-1 - Responses

Section 3-1-1

announce items from multiple object lists rule response (A) is "[current item from the multiple object list]: [run paragraph on]". [[current item from the multiple object list]: [run paragraph on]]
block vaguely going rule response (A) is "[sina][ li] tawa ala tan [sina][ li] sitelen e nasin.". [You'll have to say which compass direction to go in.]
print the final prompt rule response (A) is "> [run paragraph on]". [> [run paragraph on]]
[!!!] print the final question rule response (A) is "Would you like to ". [Would you like to ]
[!!!] print the final question rule response (B) is " or ". [ or ]
standard respond to final question rule response (A) is "Please give one of the answers above.". [Please give one of the answers above.]
[TODO: rewrite the you can also see rule response!]
[!!!] you-can-also-see rule response (A) is "[sina][ li] ". [[We] ]
[!!!] you-can-also-see rule response (B) is "On [the domain] [sina] ". [On [the domain] [we] ]
[!!!] you-can-also-see rule response (C) is "In [the domain] [sina] ". [In [the domain] [we] ]
[!!!] you-can-also-see rule response (D) is "lukin kin e ". [[regarding the player][can] also see ]
[!!!] you-can-also-see rule response (E) is "lukin e " . [[regarding the player][can] see ]
[!!!] you-can-also-see rule response (F) is " lon ni". [ here]
[!!!] use initial appearance in room descriptions rule response (A) is "On [the item] ". [On [the item] ]
[!!!] describe what's on scenery supporters in room descriptions rule response (A) is "On [the item] ". [On [the item] ]
[!!!] describe what's on mentioned supporters in room descriptions rule response (A) is "On [the item] ". [On [the item] ]
print empty inventory rule response (A) is "[sina][ li] jo ala.". [[We] [are] carrying nothing.]
print standard inventory rule response (A) is "[sina][ li] jo:[line break]". [[We] [are] carrying:[line break]]
report other people taking inventory rule response (A) is "[actor] li alasa lon ijo ona.". [[The actor] [look] through [their] possessions.]
can't take yourself rule response (A) is "[sina][ li] ken ala tawa jo e [noun] tan ni: [sina][ li] jo e [sina].". [[We] [are] always self-possessed.]
can't take other people rule response (A) is "[sina][ li] tawa jo ala e [noun] tan ni: [ona][ li] wile ala e ni.". [I don't suppose [the noun] [would care] for that.]
[...] can't take component parts rule response (A) is "[sina][ li] ken ala tawa jo e [noun] tan ni: [ona][ li] wan [whole].". [[regarding the noun][Those] [seem] to be a part of [the whole].]
can't take people's possessions rule response (A) is "[sina][ li] tawa jo ala e [noun] tan ni: [owner][ li] jo [regarding the noun][ona].". [[regarding the noun][Those] [seem] to belong to [the owner].]
can't take items out of play rule response (A) is "[sina][ li] ken ala tawa jo e [noun] tan ni: [regarding the noun][ona] lon ala ni.". [[regarding the noun][Those] [aren't] available.]
can't take what you're inside rule response (A) is "[sina][ li] ken ala tawa jo e [noun] tan ni: [noun][ li] jo [sina].". [[We] [would have] to get [if noun is a supporter]off[otherwise]out of[end if] [the noun] first.]
can't take what's already taken rule response (A) is "[sina][ li] ken ala tawa jo e [noun] tan ni: tenpo ni la [sina][ li] jo e [regarding the noun][ona].". [[We] already [have] [regarding the noun][those].]
can't take scenery rule response (A) is "[sina][ li] ken ala jo e [noun].". [[regarding the noun][They're] hardly portable.]
can only take things rule response (A) is "[sina][ li] ken ala jo e [noun].". [[We] [cannot] carry [the noun].]
[!!!] can't take what's fixed in place rule response (A) is "[regarding the noun][They're] fixed in place.". [[regarding the noun][They're] fixed in place.]
[...] use player's holdall to avoid exceeding carrying capacity rule response (A) is "(pana e [transferred item] lon [current working sack])[command clarification break]". [(putting [the transferred item] into [the current working sack] to make room)[command clarification break]]
[!!!] can't exceed carrying capacity rule response (A) is "[We]['re] carrying too many things already.". [[We]['re] carrying too many things already.]
standard report taking rule response (A) is "tawa jo.". [Taken.]
standard report taking rule response (B) is "[actor][ li] tawa jo e [noun].". [[The actor] [pick] up [the noun].]
[!!!] can't remove what's not inside rule response (A) is "But [regarding the noun][they] [aren't] there now.". [But [regarding the noun][they] [aren't] there now.]
[!!!] can't remove from people rule response (A) is "[regarding the noun][Those] [seem] to belong to [the owner].". [[regarding the noun][Those] [seem] to belong to [the owner].]
[!!!] can't drop yourself rule response (A) is "[We] [lack] the dexterity.". [[We] [lack] the dexterity.]
[!!!] can't drop body parts rule response (A) is "[We] [can't drop] part of [ourselves].". [[We] [can't drop] part of [ourselves].]
[!!!] can't drop what's already dropped rule response (A) is "[The noun] [are] already here.". [[The noun] [are] already here.]
[!!!] can't drop what's not held rule response (A) is "[We] [haven't] got [regarding the noun][those].". [[We] [haven't] got [regarding the noun][those].]
[!!!] can't drop clothes being worn rule response (A) is "(first taking [the noun] off)[command clarification break]". [(first taking [the noun] off)[command clarification break]]
[!!!] can't drop if this exceeds carrying capacity rule response (A) is "[There] [are] no more room on [the receptacle].". [[There] [are] no more room on [the receptacle].]
[!!!] can't drop if this exceeds carrying capacity rule response (B) is "[There] [are] no more room in [the receptacle].". [[There] [are] no more room in [the receptacle].]
standard report dropping rule response (A) is "pana.". [Dropped.]
standard report dropping rule response (B) is "[actor][ li] pana e [noun].". [[The actor] [put] down [the noun].]
[!!!] can't put something on itself rule response (A) is "[We] [can't put] something on top of itself.". [[We] [can't put] something on top of itself.]
[!!!] can't put onto what's not a supporter rule response (A) is "[sina] wile ala ". [Putting things on [the second noun] [would achieve] nothing.]
[!!!] can't put clothes being worn rule response (A) is "(first taking [regarding the noun][them] off)[command clarification break]". [(first taking [regarding the noun][them] off)[command clarification break]]
[!!!] can't put if this exceeds carrying capacity rule response (A) is "[There] [are] no more room on [the second noun].". [[There] [are] no more room on [the second noun].]
concise report putting rule response (A) is "pana.". [Done.]
[!!!] standard report putting rule response (A) is "[The actor] [put] [the noun] on [the second noun].". [[The actor] [put] [the noun] on [the second noun].]
[!!!] can't insert something into itself rule response (A) is "[We] [can't put] something inside itself.". [[We] [can't put] something inside itself.]
[!!!] can't insert into closed containers rule response (A) is "[The second noun] [are] closed.". [[The second noun] [are] closed.]
[!!!] can't insert into what's not a container rule response (A) is "[regarding the second noun][Those] [can't contain] things.". [[regarding the second noun][Those] [can't contain] things.]
[!!!] can't insert clothes being worn rule response (A) is "(first taking [regarding the noun][them] off)[command clarification break]". [(first taking [regarding the noun][them] off)[command clarification break]]
[!!!] can't insert if this exceeds carrying capacity rule response (A) is "[There] [are] no more room in [the second noun].". [[There] [are] no more room in [the second noun].]
[!!!] concise report inserting rule response (A) is "Done.". [Done.]
[!!!] standard report inserting rule response (A) is "[The actor] [put] [the noun] into [the second noun].". [[The actor] [put] [the noun] into [the second noun].]
[!!!] can't eat unless edible rule response (A) is "[regarding the noun][They're] plainly inedible.". [[regarding the noun][They're] plainly inedible.]
[!!!] can't eat clothing without removing it first rule response (A) is "(first taking [the noun] off)[command clarification break]". [(first taking [the noun] off)[command clarification break]]
[!!!] can't eat other people's food rule response (A) is "[The owner] [might not appreciate] that.". [[The owner] [might not appreciate] that.]
[!!!] standard report eating rule response (A) is "[We] [eat] [the noun]. Not bad.". [[We] [eat] [the noun]. Not bad.]
[!!!] standard report eating rule response (B) is "[The actor] [eat] [the noun].". [[The actor] [eat] [the noun].]
[!!!] stand up before going rule response (A) is "(first getting off [the chaise])[command clarification break]". [(first getting off [the chaise])[command clarification break]]
[!!!] can't travel in what's not a vehicle rule response (A) is "[We] [would have] to get off [the nonvehicle] first.". [[We] [would have] to get off [the nonvehicle] first.]
[!!!] can't travel in what's not a vehicle rule response (B) is "[We] [would have] to get out of [the nonvehicle] first.". [[We] [would have] to get out of [the nonvehicle] first.]
[!!!] can't go through undescribed doors rule response (A) is "[We] [can't go] that way.". [[We] [can't go] that way.]
[!!!] can't go through closed doors rule response (A) is "(first opening [the door gone through])[command clarification break]". [(first opening [the door gone through])[command clarification break]]
[!!!] can't go that way rule response (A) is "[We] [can't go] that way.". [[We] [can't go] that way.]
[!!!] can't go that way rule response (B) is "[We] [can't], since [the door gone through] [lead] nowhere.". [[We] [can't], since [the door gone through] [lead] nowhere.]
[!!!] describe room gone into rule response (A) is "[The actor] [go] up". [[The actor] [go] up]
[!!!] describe room gone into rule response (B) is "[The actor] [go] down". [[The actor] [go] down]
[!!!] describe room gone into rule response (C) is "[The actor] [go] [noun]". [[The actor] [go] [noun]]
[!!!] describe room gone into rule response (D) is "[The actor] [arrive] from above". [[The actor] [arrive] from above]
[!!!] describe room gone into rule response (E) is "[The actor] [arrive] from below". [[The actor] [arrive] from below]
[!!!] describe room gone into rule response (F) is "[The actor] [arrive] from [the back way]". [[The actor] [arrive] from [the back way]]
[!!!] describe room gone into rule response (G) is "[The actor] [arrive]". [[The actor] [arrive]]
[!!!] describe room gone into rule response (H) is "[The actor] [arrive] at [the room gone to] from above". [[The actor] [arrive] at [the room gone to] from above]
[!!!] describe room gone into rule response (I) is "[The actor] [arrive] at [the room gone to] from below". [[The actor] [arrive] at [the room gone to] from below]
[!!!] describe room gone into rule response (J) is "[The actor] [arrive] at [the room gone to] from [the back way]". [[The actor] [arrive] at [the room gone to] from [the back way]]
[!!!] describe room gone into rule response (K) is "[The actor] [go] through [the noun]". [[The actor] [go] through [the noun]]
[!!!] describe room gone into rule response (L) is "[The actor] [arrive] from [the noun]". [[The actor] [arrive] from [the noun]]
[!!!] describe room gone into rule response (M) is "on [the vehicle gone by]". [on [the vehicle gone by]]
[!!!] describe room gone into rule response (N) is "in [the vehicle gone by]". [in [the vehicle gone by]]
[!!!] describe room gone into rule response (O) is ", pushing [the thing gone with] in front, and [us] along too". [, pushing [the thing gone with] in front, and [us] along too]
[!!!] describe room gone into rule response (P) is ", pushing [the thing gone with] in front". [, pushing [the thing gone with] in front]
[!!!] describe room gone into rule response (Q) is ", pushing [the thing gone with] away". [, pushing [the thing gone with] away]
[!!!] describe room gone into rule response (R) is ", pushing [the thing gone with] in". [, pushing [the thing gone with] in]
[!!!] describe room gone into rule response (S) is ", taking [us] along". [, taking [us] along]
[!!!] can't enter what's already entered rule response (A) is "But [we]['re] already on [the noun].". [But [we]['re] already on [the noun].]
[!!!] can't enter what's already entered rule response (B) is "But [we]['re] already in [the noun].". [But [we]['re] already in [the noun].]
[!!!] can't enter what's not enterable rule response (A) is "[regarding the noun][They're] not something [we] [can] stand on.". [[regarding the noun][They're] not something [we] [can] stand on.]
[!!!] can't enter what's not enterable rule response (B) is "[regarding the noun][They're] not something [we] [can] sit down on.". [[regarding the noun][They're] not something [we] [can] sit down on.]
[!!!] can't enter what's not enterable rule response (C) is "[regarding the noun][They're] not something [we] [can] lie down on.". [[regarding the noun][They're] not something [we] [can] lie down on.]
[!!!] can't enter what's not enterable rule response (D) is "[regarding the noun][They're] not something [we] [can] enter.". [[regarding the noun][They're] not something [we] [can] enter.]
[!!!] can't enter closed containers rule response (A) is "[We] [can't get] into the closed [noun].". [[We] [can't get] into the closed [noun].]
[!!!] can't enter if this exceeds carrying capacity rule response (A) is "[There] [are] no more room on [the noun].". [[There] [are] no more room on [the noun].]
[!!!] can't enter if this exceeds carrying capacity rule response (B) is "[There] [are] no more room in [the noun].". [[There] [are] no more room in [the noun].]
[!!!] can't enter something carried rule response (A) is "[We] [can] only get into something free-standing.". [[We] [can] only get into something free-standing.]
[!!!] implicitly pass through other barriers rule response (A) is "(getting off [the current home])[command clarification break]". [(getting off [the current home])[command clarification break]]
[!!!] implicitly pass through other barriers rule response (B) is "(getting out of [the current home])[command clarification break]". [(getting out of [the current home])[command clarification break]]
[!!!] implicitly pass through other barriers rule response (C) is "(getting onto [the target])[command clarification break]". [(getting onto [the target])[command clarification break]]
[!!!] implicitly pass through other barriers rule response (D) is "(getting into [the target])[command clarification break]". [(getting into [the target])[command clarification break]]
[!!!] implicitly pass through other barriers rule response (E) is "(entering [the target])[command clarification break]". [(entering [the target])[command clarification break]]
[!!!] standard report entering rule response (A) is "[We] [get] onto [the noun].". [[We] [get] onto [the noun].]
[!!!] standard report entering rule response (B) is "[We] [get] into [the noun].". [[We] [get] into [the noun].]
[!!!] standard report entering rule response (C) is "[The actor] [get] into [the noun].". [[The actor] [get] into [the noun].]
[!!!] standard report entering rule response (D) is "[The actor] [get] onto [the noun].". [[The actor] [get] onto [the noun].]
[!!!] can't exit when not inside anything rule response (A) is "But [we] [aren't] in anything at the [if story tense is present tense]moment[otherwise]time[end if].". [But [we] [aren't] in anything at the [if story tense is present tense]moment[otherwise]time[end if].]
[!!!] can't exit closed containers rule response (A) is "You can't get out of the closed [cage].". [You can't get out of the closed [cage].]
[!!!] standard report exiting rule response (A) is "[We] [get] off [the container exited from].". [[We] [get] off [the container exited from].]
[!!!] standard report exiting rule response (B) is "[We] [get] out of [the container exited from].". [[We] [get] out of [the container exited from].]
[!!!] standard report exiting rule response (C) is "[The actor] [get] out of [the container exited from].". [[The actor] [get] out of [the container exited from].]
[!!!] can't get off things rule response (A) is "But [we] [aren't] on [the noun] at the [if story tense is present tense]moment[otherwise]time[end if].". [But [we] [aren't] on [the noun] at the [if story tense is present tense]moment[otherwise]time[end if].]
[!!!] standard report getting off rule response (A) is "[The actor] [get] off [the noun].". [[The actor] [get] off [the noun].]
[!!!] room description heading rule response (A) is "Darkness". [Darkness]
[!!!] room description heading rule response (B) is " (on [the intermediate level])". [ (on [the intermediate level])]
[!!!] room description heading rule response (C) is " (in [the intermediate level])". [ (in [the intermediate level])]
[!!!] room description body text rule response (A) is "[It] [are] pitch dark, and [we] [can't see] a thing.". [[It] [are] pitch dark, and [we] [can't see] a thing.]
[!!!] other people looking rule response (A) is "[The actor] [look] around.". [[The actor] [look] around.]
[!!!] examine directions rule response (A) is "[We] [see] nothing unexpected in that direction.". [[We] [see] nothing unexpected in that direction.]
[!!!] examine containers rule response (A) is "In [the noun] ". [In [the noun] ]
[!!!] examine containers rule response (B) is "[The noun] [are] empty.". [[The noun] [are] empty.]
[!!!] examine supporters rule response (A) is "On [the noun] ". [On [the noun] ]
[!!!] examine devices rule response (A) is "[The noun] [are] [if story tense is present tense]currently [end if]switched [if the noun is switched on]on[otherwise]off[end if].". [[The noun] [are] [if story tense is present tense]currently [end if]switched [if the noun is switched on]on[otherwise]off[end if].]
[!!!] examine undescribed things rule response (A) is "[We] [see] nothing special about [the noun].". [[We] [see] nothing special about [the noun].]
[!!!] report other people examining rule response (A) is "[The actor] [look] closely at [the noun].". [[The actor] [look] closely at [the noun].]
[!!!] standard looking under rule response (A) is "[We] [find] nothing of interest.". [[We] [find] nothing of interest.]
[!!!] report other people looking under rule response (A) is "[The actor] [look] under [the noun].". [[The actor] [look] under [the noun].]
[!!!] can't search unless container or supporter rule response (A) is "[We] [find] nothing of interest.". [[We] [find] nothing of interest.]
[!!!] can't search closed opaque containers rule response (A) is "[We] [can't see] inside, since [the noun] [are] closed.". [[We] [can't see] inside, since [the noun] [are] closed.]
[!!!] standard search containers rule response (A) is "In [the noun] ". [In [the noun] ]
[!!!] standard search containers rule response (B) is "[The noun] [are] empty.". [[The noun] [are] empty.]
[!!!] standard search supporters rule response (A) is "On [the noun] ". [On [the noun] ]
[!!!] standard search supporters rule response (B) is "[There] [are] nothing on [the noun].". [[There] [are] nothing on [the noun].]
[!!!] report other people searching rule response (A) is "[The actor] [search] [the noun].". [[The actor] [search] [the noun].]
[!!!] block consulting rule response (A) is "[We] [discover] nothing of interest in [the noun].". [[We] [discover] nothing of interest in [the noun].]
[!!!] block consulting rule response (B) is "[The actor] [look] at [the noun].". [[The actor] [look] at [the noun].]
[!!!] can't lock without a lock rule response (A) is "[regarding the noun][Those] [don't] seem to be something [we] [can] lock.". [[regarding the noun][Those] [don't] seem to be something [we] [can] lock.]
[!!!] can't lock what's already locked rule response (A) is "[regarding the noun][They're] locked at the [if story tense is present tense]moment[otherwise]time[end if].". [[regarding the noun][They're] locked at the [if story tense is present tense]moment[otherwise]time[end if].]
[!!!] can't lock what's open rule response (A) is "First [we] [would have] to close [the noun].". [First [we] [would have] to close [the noun].]
[!!!] can't lock without the correct key rule response (A) is "[regarding the second noun][Those] [don't] seem to fit the lock.". [[regarding the second noun][Those] [don't] seem to fit the lock.]
[!!!] standard report locking rule response (A) is "[We] [lock] [the noun].". [[We] [lock] [the noun].]
[!!!] standard report locking rule response (B) is "[The actor] [lock] [the noun].". [[The actor] [lock] [the noun].]
[!!!] can't unlock without a lock rule response (A) is "[regarding the noun][Those] [don't] seem to be something [we] [can] unlock.". [[regarding the noun][Those] [don't] seem to be something [we] [can] unlock.]
[!!!] can't unlock what's already unlocked rule response (A) is "[regarding the noun][They're] unlocked at the [if story tense is present tense]moment[otherwise]time[end if].". [[regarding the noun][They're] unlocked at the [if story tense is present tense]moment[otherwise]time[end if].]
[!!!] can't unlock without the correct key rule response (A) is "[regarding the second noun][Those] [don't] seem to fit the lock.". [[regarding the second noun][Those] [don't] seem to fit the lock.]
[!!!] standard report unlocking rule response (A) is "[We] [unlock] [the noun].". [[We] [unlock] [the noun].]
[!!!] standard report unlocking rule response (B) is "[The actor] [unlock] [the noun].". [[The actor] [unlock] [the noun].]
[!!!] can't switch on unless switchable rule response (A) is "[regarding the noun][They] [aren't] something [we] [can] switch.". [[regarding the noun][They] [aren't] something [we] [can] switch.]
[!!!] can't switch on what's already on rule response (A) is "[regarding the noun][They're] already on.". [[regarding the noun][They're] already on.]
[!!!] standard report switching on rule response (A) is "[The actor] [switch] [the noun] on.". [[The actor] [switch] [the noun] on.]
[!!!] can't switch off unless switchable rule response (A) is "[regarding the noun][They] [aren't] something [we] [can] switch.". [[regarding the noun][They] [aren't] something [we] [can] switch.]
[!!!] can't switch off what's already off rule response (A) is "[regarding the noun][They're] already off.". [[regarding the noun][They're] already off.]
[!!!] standard report switching off rule response (A) is "[The actor] [switch] [the noun] off.". [[The actor] [switch] [the noun] off.]
[!!!] can't open unless openable rule response (A) is "[regarding the noun][They] [aren't] something [we] [can] open.". [[regarding the noun][They] [aren't] something [we] [can] open.]
[!!!] can't open what's locked rule response (A) is "[regarding the noun][They] [seem] to be locked.". [[regarding the noun][They] [seem] to be locked.]
[!!!] can't open what's already open rule response (A) is "[regarding the noun][They're] already open.". [[regarding the noun][They're] already open.]
[!!!] reveal any newly visible interior rule response (A) is "[We] [open] [the noun], revealing ". [[We] [open] [the noun], revealing ]
[!!!] standard report opening rule response (A) is "[We] [open] [the noun].". [[We] [open] [the noun].]
[!!!] standard report opening rule response (B) is "[The actor] [open] [the noun].". [[The actor] [open] [the noun].]
[!!!] standard report opening rule response (C) is "[The noun] [open].". [[The noun] [open].]
[!!!] can't close unless openable rule response (A) is "[regarding the noun][They] [aren't] something [we] [can] close.". [[regarding the noun][They] [aren't] something [we] [can] close.]
[!!!] can't close what's already closed rule response (A) is "[regarding the noun][They're] already closed.". [[regarding the noun][They're] already closed.]
[!!!] standard report closing rule response (A) is "[We] [close] [the noun].". [[We] [close] [the noun].]
[!!!] standard report closing rule response (B) is "[The actor] [close] [the noun].". [[The actor] [close] [the noun].]
[!!!] standard report closing rule response (C) is "[The noun] [close].". [[The noun] [close].]
[!!!] can't wear what's not clothing rule response (A) is "[We] [can't wear] [regarding the noun][those]!". [[We] [can't wear] [regarding the noun][those]!]
[!!!] can't wear what's not held rule response (A) is "[We] [aren't] holding [regarding the noun][those]!". [[We] [aren't] holding [regarding the noun][those]!]
[!!!] can't wear what's already worn rule response (A) is "[We]['re] already wearing [regarding the noun][those]!". [[We]['re] already wearing [regarding the noun][those]!]
[!!!] standard report wearing rule response (A) is "[We] [put] on [the noun].". [[We] [put] on [the noun].]
[!!!] standard report wearing rule response (B) is "[The actor] [put] on [the noun].". [[The actor] [put] on [the noun].]
[!!!] can't take off what's not worn rule response (A) is "[We] [aren't] wearing [the noun].". [[We] [aren't] wearing [the noun].]
[!!!] can't exceed carrying capacity when taking off rule response (A) is "[We]['re] carrying too many things already.". [[We]['re] carrying too many things already.]
[!!!] standard report taking off rule response (A) is "[We] [take] off [the noun].". [[We] [take] off [the noun].]
[!!!] standard report taking off rule response (B) is "[The actor] [take] off [the noun].". [[The actor] [take] off [the noun].]
[!!!] can't give what you haven't got rule response (A) is "[We] [aren't] holding [the noun].". [[We] [aren't] holding [the noun].]
[!!!] can't give to yourself rule response (A) is "[We] [can't give] [the noun] to [ourselves].". [[We] [can't give] [the noun] to [ourselves].]
[!!!] can't give to a non-person rule response (A) is "[The second noun] [aren't] able to receive things.". [[The second noun] [aren't] able to receive things.]
[!!!] can't give clothes being worn rule response (A) is "(first taking [the noun] off)[command clarification break]". [(first taking [the noun] off)[command clarification break]]
[!!!] block giving rule response (A) is "[The second noun] [don't] seem interested.". [[The second noun] [don't] seem interested.]
[!!!] can't exceed carrying capacity when giving rule response (A) is "[The second noun] [are] carrying too many things already.". [[The second noun] [are] carrying too many things already.]
[!!!] standard report giving rule response (A) is "[We] [give] [the noun] to [the second noun].". [[We] [give] [the noun] to [the second noun].]
[!!!] standard report giving rule response (B) is "[The actor] [give] [the noun] to [us].". [[The actor] [give] [the noun] to [us].]
[!!!] standard report giving rule response (C) is "[The actor] [give] [the noun] to [the second noun].". [[The actor] [give] [the noun] to [the second noun].]
[!!!] can't show what you haven't got rule response (A) is "[We] [aren't] holding [the noun].". [[We] [aren't] holding [the noun].]
[!!!] block showing rule response (A) is "[The second noun] [are] unimpressed.". [[The second noun] [are] unimpressed.]
[!!!] block waking rule response (A) is "That [seem] unnecessary.". [That [seem] unnecessary.]
[!!!] implicitly remove thrown clothing rule response (A) is "(first taking [the noun] off)[command clarification break]". [(first taking [the noun] off)[command clarification break]]
[!!!] futile to throw things at inanimate objects rule response (A) is "Futile.". [Futile.]
[!!!] block throwing at rule response (A) is "[We] [lack] the nerve when it [if story tense is the past tense]came[otherwise]comes[end if] to the crucial moment.". [[We] [lack] the nerve when it [if story tense is the past tense]came[otherwise]comes[end if] to the crucial moment.]
[!!!] block attacking rule response (A) is "Violence [aren't] the answer to this one.". [Violence [aren't] the answer to this one.]
[!!!] kissing yourself rule response (A) is "[We] [don't] get much from that.". [[We] [don't] get much from that.]
[!!!] block kissing rule response (A) is "[The noun] [might not] like that.". [[The noun] [might not] like that.]
[!!!] block answering rule response (A) is "[There] [are] no reply.". [[There] [are] no reply.]
[!!!] telling yourself rule response (A) is "[We] [talk] to [ourselves] a while.". [[We] [talk] to [ourselves] a while.]
[!!!] block telling rule response (A) is "This [provoke] no reaction.". [This [provoke] no reaction.]
[!!!] block asking rule response (A) is "[There] [are] no reply.". [[There] [are] no reply.]
[!!!] standard report waiting rule response (A) is "Time [pass].". [Time [pass].]
[!!!] standard report waiting rule response (B) is "[The actor] [wait].". [[The actor] [wait].]
[!!!] report touching yourself rule response (A) is "[We] [achieve] nothing by this.". [[We] [achieve] nothing by this.]
[!!!] report touching yourself rule response (B) is "[The actor] [touch] [themselves].". [[The actor] [touch] [themselves].]
[!!!] report touching other people rule response (A) is "[The noun] [might not like] that.". [[The noun] [might not like] that.]
[!!!] report touching other people rule response (B) is "[The actor] [touch] [us].". [[The actor] [touch] [us].]
[!!!] report touching other people rule response (C) is "[The actor] [touch] [the noun].". [[The actor] [touch] [the noun].]
[!!!] report touching things rule response (A) is "[We] [feel] nothing unexpected.". [[We] [feel] nothing unexpected.]
[!!!] report touching things rule response (B) is "[The actor] [touch] [the noun].". [[The actor] [touch] [the noun].]
[!!!] can't wave what's not held rule response (A) is "But [we] [aren't] holding [regarding the noun][those].". [But [we] [aren't] holding [regarding the noun][those].]
[!!!] report waving things rule response (A) is "[We] [wave] [the noun].". [[We] [wave] [the noun].]
[!!!] report waving things rule response (B) is "[The actor] [wave] [the noun].". [[The actor] [wave] [the noun].]
[!!!] can't pull what's fixed in place rule response (A) is "[regarding the noun][They] [are] fixed in place.". [[regarding the noun][They] [are] fixed in place.]
[!!!] can't pull scenery rule response (A) is "[We] [are] unable to.". [[We] [are] unable to.]
[!!!] can't pull people rule response (A) is "[The noun] [might not like] that.". [[The noun] [might not like] that.]
[!!!] report pulling rule response (A) is "Nothing obvious [happen].". [Nothing obvious [happen].]
[!!!] report pulling rule response (B) is "[The actor] [pull] [the noun].". [[The actor] [pull] [the noun].]
[!!!] can't push what's fixed in place rule response (A) is "[regarding the noun][They] [are] fixed in place.". [[regarding the noun][They] [are] fixed in place.]
[!!!] can't push scenery rule response (A) is "[We] [are] unable to.". [[We] [are] unable to.]
[!!!] can't push people rule response (A) is "[The noun] [might not like] that.". [[The noun] [might not like] that.]
[!!!] report pushing rule response (A) is "Nothing obvious [happen].". [Nothing obvious [happen].]
[!!!] report pushing rule response (B) is "[The actor] [push] [the noun].". [[The actor] [push] [the noun].]
[!!!] can't turn what's fixed in place rule response (A) is "[regarding the noun][They] [are] fixed in place.". [[regarding the noun][They] [are] fixed in place.]
[!!!] can't turn scenery rule response (A) is "[We] [are] unable to.". [[We] [are] unable to.]
[!!!] can't turn people rule response (A) is "[The noun] [might not like] that.". [[The noun] [might not like] that.]
[!!!] report turning rule response (A) is "Nothing obvious [happen].". [Nothing obvious [happen].]
[!!!] report turning rule response (B) is "[The actor] [turn] [the noun].". [[The actor] [turn] [the noun].]
[!!!] can't push unpushable things rule response (A) is "[The noun] [cannot] be pushed from place to place.". [[The noun] [cannot] be pushed from place to place.]
[!!!] can't push to non-directions rule response (A) is "[regarding the noun][They] [aren't] a direction.". [[regarding the noun][They] [aren't] a direction.]
[!!!] can't push vertically rule response (A) is "[The noun] [cannot] be pushed up or down.". [[The noun] [cannot] be pushed up or down.]
[!!!] can't push from within rule response (A) is "[The noun] [cannot] be pushed from here.". [[The noun] [cannot] be pushed from here.]
[!!!] block pushing in directions rule response (A) is "[The noun] [cannot] be pushed from place to place.". [[The noun] [cannot] be pushed from place to place.]
[!!!] innuendo about squeezing people rule response (A) is "[The noun] [might not like] that.". [[The noun] [might not like] that.]
[!!!] report squeezing rule response (A) is "[We] [achieve] nothing by this.". [[We] [achieve] nothing by this.]
[!!!] report squeezing rule response (B) is "[The actor] [squeeze] [the noun].". [[The actor] [squeeze] [the noun].]
[!!!] block saying yes rule response (A) is "That was a rhetorical question.". [That was a rhetorical question.]
[!!!] block saying no rule response (A) is "That was a rhetorical question.". [That was a rhetorical question.]
[!!!] block burning rule response (A) is "This dangerous act [would achieve] little.". [This dangerous act [would achieve] little.]
[!!!] block waking up rule response (A) is "The dreadful truth [are], this [are not] a dream.". [The dreadful truth [are], this [are not] a dream.]
[!!!] block thinking rule response (A) is "What a good idea.". [What a good idea.]
[!!!] report smelling rule response (A) is "[We] [smell] nothing unexpected.". [[We] [smell] nothing unexpected.]
[!!!] report smelling rule response (B) is "[The actor] [sniff].". [[The actor] [sniff].]
[!!!] report listening rule response (A) is "[We] [hear] nothing unexpected.". [[We] [hear] nothing unexpected.]
[!!!] report listening rule response (B) is "[The actor] [listen].". [[The actor] [listen].]
[!!!] report tasting rule response (A) is "[We] [taste] nothing unexpected.". [[We] [taste] nothing unexpected.]
[!!!] report tasting rule response (B) is "[The actor] [taste] [the noun].". [[The actor] [taste] [the noun].]
[!!!] block cutting rule response (A) is "Cutting [regarding the noun][them] up [would achieve] little.". [Cutting [regarding the noun][them] up [would achieve] little.]
[!!!] report jumping rule response (A) is "[We] [jump] on the spot.". [[We] [jump] on the spot.]
[!!!] report jumping rule response (B) is "[The actor] [jump] on the spot.". [[The actor] [jump] on the spot.]
[!!!] block tying rule response (A) is "[We] [would achieve] nothing by this.". [[We] [would achieve] nothing by this.]
[!!!] block drinking rule response (A) is "[There's] nothing suitable to drink here.". [[There's] nothing suitable to drink here.]
[!!!] block saying sorry rule response (A) is "Oh, don't [if American dialect option is active]apologize[otherwise]apologise[end if].". [Oh, don't [if American dialect option is active]apologize[otherwise]apologise[end if].]
[!!!] block swinging rule response (A) is "[There's] nothing sensible to swing here.". [[There's] nothing sensible to swing here.]
[!!!] can't rub another person rule response (A) is "[The noun] [might not like] that.". [[The noun] [might not like] that.]
[!!!] report rubbing rule response (A) is "[We] [rub] [the noun].". [[We] [rub] [the noun].]
[!!!] report rubbing rule response (B) is "[The actor] [rub] [the noun].". [[The actor] [rub] [the noun].]
[!!!] block setting it to rule response (A) is "No, [we] [can't set] [regarding the noun][those] to anything.". [No, [we] [can't set] [regarding the noun][those] to anything.]
[!!!] report waving hands rule response (A) is "[We] [wave].". [[We] [wave].]
[!!!] report waving hands rule response (B) is "[The actor] [wave].". [[The actor] [wave].]
[!!!] block buying rule response (A) is "Nothing [are] on sale.". [Nothing [are] on sale.]
[!!!] block climbing rule response (A) is "Little [are] to be achieved by that.". [Little [are] to be achieved by that.]
[!!!] block sleeping rule response (A) is "[We] [aren't] feeling especially drowsy.". [[We] [aren't] feeling especially drowsy.]
[!!!] adjust light rule response (A) is "[It] [are] [if story tense is present tense]now [end if]pitch dark in [if story tense is present tense]here[else]there[end if]!". [[It] [are] [if story tense is present tense]now [end if]pitch dark in [if story tense is present tense]here[else]there[end if]!]
[!!!] generate action rule response (A) is "(considering the first sixteen objects only)[command clarification break]". [(considering the first sixteen objects only)[command clarification break]]
[!!!] generate action rule response (B) is "Nothing to do!". [Nothing to do!]
[!!!] basic accessibility rule response (A) is "You must name something more substantial.". [You must name something more substantial.]
[!!!] basic visibility rule response (A) is "[It] [are] pitch dark, and [we] [can't see] a thing.". [[It] [are] pitch dark, and [we] [can't see] a thing.]
[!!!] requested actions require persuasion rule response (A) is "[The noun] [have] better things to do.". [[The noun] [have] better things to do.]
[!!!] carry out requested actions rule response (A) is "[The noun] [are] unable to do that.". [[The noun] [are] unable to do that.]
[!!!] access through barriers rule response (A) is "[regarding the noun][Those] [aren't] available.". [[regarding the noun][Those] [aren't] available.]
[!!!] can't reach inside closed containers rule response (A) is "[The noun] [aren't] open.". [[The noun] [aren't] open.]
[!!!] can't reach inside rooms rule response (A) is "[We] [can't] reach into [the noun].". [[We] [can't] reach into [the noun].]
[!!!] can't reach outside closed containers rule response (A) is "[The noun] [aren't] open.". [[The noun] [aren't] open.]
[!!!] list writer internal rule response (A) is " (". [ (]
[!!!] list writer internal rule response (B) is ")". [)]
[!!!] list writer internal rule response (C) is " and ". [ and ]
[!!!] list writer internal rule response (D) is "providing light". [providing light]
[!!!] list writer internal rule response (E) is "closed". [closed]
[!!!] list writer internal rule response (F) is "empty". [empty]
[!!!] list writer internal rule response (G) is "closed and empty". [closed and empty]
[!!!] list writer internal rule response (H) is "closed and providing light". [closed and providing light]
[!!!] list writer internal rule response (I) is "empty and providing light". [empty and providing light]
[!!!] list writer internal rule response (J) is "closed, empty[if serial comma option is active],[end if] and providing light". [closed, empty[if serial comma option is active],[end if] and providing light]
[!!!] list writer internal rule response (K) is "providing light and being worn". [providing light and being worn]
[!!!] list writer internal rule response (L) is "being worn". [being worn]
[!!!] list writer internal rule response (M) is "open". [open]
[!!!] list writer internal rule response (N) is "open but empty". [open but empty]
[!!!] list writer internal rule response (O) is "closed". [closed]
[!!!] list writer internal rule response (P) is "closed and locked". [closed and locked]
[!!!] list writer internal rule response (Q) is "containing". [containing]
[!!!] list writer internal rule response (R) is "on [if the noun is a person]whom[otherwise]which[end if] ". [on [if the noun is a person]whom[otherwise]which[end if] ]
[!!!] list writer internal rule response (S) is ", on top of [if the noun is a person]whom[otherwise]which[end if] ". [, on top of [if the noun is a person]whom[otherwise]which[end if] ]
[!!!] list writer internal rule response (T) is "in [if the noun is a person]whom[otherwise]which[end if] ". [in [if the noun is a person]whom[otherwise]which[end if] ]
[!!!] list writer internal rule response (U) is ", inside [if the noun is a person]whom[otherwise]which[end if] ". [, inside [if the noun is a person]whom[otherwise]which[end if] ]
[!!!] list writer internal rule response (V) is "[regarding list writer internals][are]". [[regarding list writer internals][are]]
[!!!] list writer internal rule response (W) is "[regarding list writer internals][are] nothing". [[regarding list writer internals][are] nothing]
[!!!] list writer internal rule response (X) is "Nothing". [Nothing]
[!!!] list writer internal rule response (Y) is "nothing". [nothing]
[!!!] action processing internal rule response (A) is "[bracket]That command asks to do something outside of play, so it can only make sense from you to me. [The noun] cannot be asked to do this.[close bracket]". [[bracket]That command asks to do something outside of play, so it can only make sense from you to me. [The noun] cannot be asked to do this.[close bracket]]
[...] action processing internal rule response (B) is "sina wile sitelen e ijo.". [You must name an object.]
[...] action processing internal rule response (C) is "sina wile ala sitelen e ijo.". [You may not name an object.]
[...] action processing internal rule response (D) is "sina wile sitelen e nimi ijo.". [You must supply a noun.]
[...] action processing internal rule response (E) is "sina wile ala sitelen e nimi ijo.". [You may not supply a noun.]
[...] action processing internal rule response (F) is "sina wile sitelen e ijo nanpa tu.". [You must name a second object.]
[...] action processing internal rule response (G) is "sina wile ala sitelen e ijo nanpa tu.". [You may not name a second object.]
[...] action processing internal rule response (H) is "sina wile sitelen e nimi ijo pi nanpa tu.". [You must supply a second noun.]
[...] action processing internal rule response (I) is "sina wile sitelen e nimi ijo pi nanpa tu.". [You may not supply a second noun.]
[!!!] action processing internal rule response (J) is "(Since something dramatic has happened, your list of commands has been cut short.)". [(Since something dramatic has happened, your list of commands has been cut short.)]
[!!!] action processing internal rule response (K) is "I didn't understand that instruction.". [I didn't understand that instruction.]
[!!!] parser error internal rule response (A) is "I didn't understand that sentence.". [I didn't understand that sentence.]
[!!!] parser error internal rule response (B) is "I only understood you as far as wanting to ". [I only understood you as far as wanting to ]
[!!!] parser error internal rule response (C) is "I only understood you as far as wanting to (go) ". [I only understood you as far as wanting to (go) ]
parser error internal rule response (D) is "mi sona ala e nanpa ni.". [I didn't understand that number.]
[!!!] parser error internal rule response (E) is "[We] [can't] see any such thing.". [[We] [can't] see any such thing.]
[!!!] parser error internal rule response (F) is "You seem to have said too little!". [You seem to have said too little!]
[!!!] parser error internal rule response (G) is "[We] [aren't] holding that!". [[We] [aren't] holding that!]
[!!!] parser error internal rule response (H) is "You can't use multiple objects with that verb.". [You can't use multiple objects with that verb.]
[!!!] parser error internal rule response (I) is "You can only use multiple objects once on a line.". [You can only use multiple objects once on a line.]
[!!!] parser error internal rule response (J) is "I'm not sure what ['][pronoun i6 dictionary word]['] refers to.". [I'm not sure what ['][pronoun i6 dictionary word]['] refers to.]
[!!!] parser error internal rule response (K) is "[We] [can't] see ['][pronoun i6 dictionary word]['] ([the noun]) at the moment.". [[We] [can't] see ['][pronoun i6 dictionary word]['] ([the noun]) at the moment.]
[!!!] parser error internal rule response (L) is "You excepted something not included anyway!". [You excepted something not included anyway!]
[!!!] parser error internal rule response (M) is "You can only do that to something animate.". [You can only do that to something animate.]
parser error internal rule response (N) is "mi sona ala e nimi pali ni.". [That's not a verb I [if American dialect option is active]recognize[otherwise]recognise[end if].]
[!!!] parser error internal rule response (O) is "That's not something you need to refer to in the course of this game.". [That's not something you need to refer to in the course of this game.]
[!!!] parser error internal rule response (P) is "I didn't understand the way that finished.". [I didn't understand the way that finished.]
[!!!] parser error internal rule response (Q) is "[if number understood is 0]None[otherwise]Only [number understood in words][end if] of those [regarding the number understood][are] available.". [[if number understood is 0]None[otherwise]Only [number understood in words][end if] of those [regarding the number understood][are] available.]
[!!!] parser error internal rule response (R) is "That noun did not make sense in this context.". [That noun did not make sense in this context.]
[!!!] parser error internal rule response (S) is "To repeat a command like 'frog, jump', just say 'again', not 'frog, again'.". [To repeat a command like 'frog, jump', just say 'again', not 'frog, again'.]
[!!!] parser error internal rule response (T) is "You can't begin with a comma.". [You can't begin with a comma.]
[!!!] parser error internal rule response (U) is "You seem to want to talk to someone, but I can't see whom.". [You seem to want to talk to someone, but I can't see whom.]
[!!!] parser error internal rule response (V) is "You can't talk to [the noun].". [You can't talk to [the noun].]
[!!!] parser error internal rule response (W) is "To talk to someone, try 'someone, hello' or some such.". [To talk to someone, try 'someone, hello' or some such.]
[!!!] parser error internal rule response (X) is "I beg your pardon?". [I beg your pardon?]
[!!!] parser nothing error internal rule response (A) is "Nothing to do!". [Nothing to do!]
[!!!] parser nothing error internal rule response (B) is "[There] [adapt the verb are from the third person plural] none at all available!". [[There] [adapt the verb are from the third person plural] none at all available!]
[!!!] parser nothing error internal rule response (C) is "[regarding the noun][Those] [seem] to belong to [the noun].". [[regarding the noun][Those] [seem] to belong to [the noun].]
[!!!] parser nothing error internal rule response (D) is "[regarding the noun][Those] [can't] contain things.". [[regarding the noun][Those] [can't] contain things.]
[!!!] parser nothing error internal rule response (E) is "[The noun] [aren't] open.". [[The noun] [aren't] open.]
[!!!] parser nothing error internal rule response (F) is "[The noun] [are] empty.". [[The noun] [are] empty.]
[!!!] darkness name internal rule response (A) is "Darkness". [Darkness]
[!!!] parser command internal rule response (A) is "Sorry, that can't be corrected.". [Sorry, that can't be corrected.]
[!!!] parser command internal rule response (B) is "Think nothing of it.". [Think nothing of it.]
[!!!] parser command internal rule response (C) is "'Oops' can only correct a single word.". ['Oops' can only correct a single word.]
[!!!] parser command internal rule response (D) is "You can hardly repeat that.". [You can hardly repeat that.]
[!!!] parser clarification internal rule response (A) is "Who do you mean, ". [Who do you mean, ]
[!!!] parser clarification internal rule response (B) is "Which do you mean, ". [Which do you mean, ]
[!!!] parser clarification internal rule response (C) is "Sorry, you can only have one item here. Which exactly?". [Sorry, you can only have one item here. Which exactly?]
[!!!] parser clarification internal rule response (D) is "Whom do you want [if the noun is not the player][the noun] [end if]to [parser command so far]?". [Whom do you want [if the noun is not the player][the noun] [end if]to [parser command so far]?]
[!!!] parser clarification internal rule response (E) is "What do you want [if the noun is not the player][the noun] [end if]to [parser command so far]?". [What do you want [if the noun is not the player][the noun] [end if]to [parser command so far]?]
[!!!] parser clarification internal rule response (F) is "those things". [those things]
[!!!] parser clarification internal rule response (G) is "that". [that]
[!!!] parser clarification internal rule response (H) is " or ". [ or ]
[!!!] yes or no question internal rule response (A) is "Please answer yes or no.". [Please answer yes or no.]
[!!!] print protagonist internal rule response (A) is "[We]". [[We]]
[!!!] print protagonist internal rule response (B) is "[ourselves]". [[ourselves]]
[!!!] print protagonist internal rule response (C) is "[our] former self". [[our] former self]
[!!!] standard implicit taking rule response (A) is "(first taking [the noun])[command clarification break]". [(first taking [the noun])[command clarification break]]
[!!!] standard implicit taking rule response (B) is "([the second noun] first taking [the noun])[command clarification break]". [([the second noun] first taking [the noun])[command clarification break]]
[!!!] print obituary headline rule response (A) is " You have died ". [ You have died ]
[!!!] print obituary headline rule response (B) is " You have won ". [ You have won ]
[!!!] print obituary headline rule response (C) is " The End ". [ The End ]
[!!!] immediately undo rule response (A) is "The use of 'undo' is forbidden in this story.". [The use of 'undo' is forbidden in this story.]
[!!!] immediately undo rule response (B) is "You can't 'undo' what hasn't been done!". [You can't 'undo' what hasn't been done!]
[!!!] immediately undo rule response (C) is "Your interpreter does not provide 'undo'. Sorry!". [Your interpreter does not provide 'undo'. Sorry!]
[!!!] immediately undo rule response (D) is "'Undo' failed. Sorry!". ['Undo' failed. Sorry!]
[!!!] immediately undo rule response (E) is "[bracket]Previous turn undone.[close bracket]". [[bracket]Previous turn undone.[close bracket]]
[!!!] immediately undo rule response (F) is "'Undo' capacity exhausted. Sorry!". ['Undo' capacity exhausted. Sorry!]
[!!!] quit the game rule response (A) is "Are you sure you want to quit? ". [Are you sure you want to quit? ]
[!!!] save the game rule response (A) is "Save failed.". [Save failed.]
[!!!] save the game rule response (B) is "Ok.". [Ok.]
[!!!] restore the game rule response (A) is "Restore failed.". [Restore failed.]
[!!!] restore the game rule response (B) is "Ok.". [Ok.]
[!!!] restart the game rule response (A) is "Are you sure you want to restart? ". [Are you sure you want to restart? ]
[!!!] restart the game rule response (B) is "Failed.". [Failed.]
[!!!] verify the story file rule response (A) is "The game file has verified as intact.". [The game file has verified as intact.]
[!!!] verify the story file rule response (B) is "The game file did not verify as intact, and may be corrupt.". [The game file did not verify as intact, and may be corrupt.]
[!!!] switch the story transcript on rule response (A) is "Transcripting is already on.". [Transcripting is already on.]
[!!!] switch the story transcript on rule response (B) is "Start of a transcript of". [Start of a transcript of]
[!!!] switch the story transcript on rule response (C) is "Attempt to begin transcript failed.". [Attempt to begin transcript failed.]
[!!!] switch the story transcript off rule response (A) is "Transcripting is already off.". [Transcripting is already off.]
[!!!] switch the story transcript off rule response (B) is "[line break]End of transcript.". [[line break]End of transcript.]
[!!!] switch the story transcript off rule response (C) is "Attempt to end transcript failed.". [Attempt to end transcript failed.]
[!!!] announce the score rule response (A) is "[if the story has ended]In that game you scored[otherwise]You have so far scored[end if] [score] out of a possible [maximum score], in [turn count] turn[s]". [[if the story has ended]In that game you scored[otherwise]You have so far scored[end if] [score] out of a possible [maximum score], in [turn count] turn[s]]
[!!!] announce the score rule response (B) is ", earning you the rank of ". [, earning you the rank of ]
[!!!] announce the score rule response (C) is "[There] [are] no score in this story.". [[There] [are] no score in this story.]
[!!!] announce the score rule response (D) is "[bracket]Your score has just gone up by [number understood in words] point[s].[close bracket]". [[bracket]Your score has just gone up by [number understood in words] point[s].[close bracket]]
[!!!] announce the score rule response (E) is "[bracket]Your score has just gone down by [number understood in words] point[s].[close bracket]". [[bracket]Your score has just gone down by [number understood in words] point[s].[close bracket]]
[!!!] standard report preferring abbreviated room descriptions rule response (A) is " is now in its 'superbrief' mode, which always gives short descriptions of locations (even if you haven't been there before).". [ is now in its 'superbrief' mode, which always gives short descriptions of locations (even if you haven't been there before).]
[!!!] standard report preferring unabbreviated room descriptions rule response (A) is " is now in its 'verbose' mode, which always gives long descriptions of locations (even if you've been there before).". [ is now in its 'verbose' mode, which always gives long descriptions of locations (even if you've been there before).]
[!!!] standard report preferring sometimes abbreviated room descriptions rule response (A) is " is now in its 'brief' printing mode, which gives long descriptions of places never before visited and short descriptions otherwise.". [ is now in its 'brief' printing mode, which gives long descriptions of places never before visited and short descriptions otherwise.]
[!!!] standard report switching score notification on rule response (A) is "Score notification on.". [Score notification on.]
[!!!] standard report switching score notification off rule response (A) is "Score notification off.". [Score notification off.]
[!!!] announce the pronoun meanings rule response (A) is "At the moment, ". [At the moment, ]
[!!!] announce the pronoun meanings rule response (B) is "means ". [means ]
[!!!] announce the pronoun meanings rule response (C) is "is unset". [is unset]

Section 3-1-2 (for use with Basic Screen Effects by Emily Short)

[!!!] standard pausing the game rule response (A) is "[paragraph break]Please press SPACE to continue.". [[paragraph break]Please press SPACE to continue.]

Section 3-1-3 (for use with Complex Listing by Emily Short)

[!!!] standard delimiting rule response (A) is "[second delimiter entry]". [[second delimiter entry]]
[!!!] standard delimiting rule response (B) is "[alternate second delimiter entry]". [[alternate second delimiter entry]]
[!!!] standard delimiting rule response (C) is "[first delimiter entry]". [[first delimiter entry]]

Section 3-1-4 (for use with Epistemology by Eric Eve)

[!!!] report epistemic status rule response (A) is "[noun] - [if the noun is seen]seen[otherwise]unseen[end if] / [if the noun is familiar]familiar[otherwise]unfamiliar[end if] / [if the noun is known]known[otherwise]unknown[end if].". [[noun] - [if the noun is seen]seen[otherwise]unseen[end if] / [if the noun is familiar]familiar[otherwise]unfamiliar[end if] / [if the noun is known]known[otherwise]unknown[end if].]

Section 3-1-5 (for use with Inanimate Listeners by Emily Short)

[!!!] unsuccessful persuasion of inanimate objects rule response (A) is "[The target] [cannot] do everything a person can.". [[The target] [cannot] do everything a person can.]

Section 3-1-6 (for use with Locksmith by Emily Short)

[!!!] opening doors before entering rule response (A) is "(first opening [the blocking door])[command clarification break]". [(first opening [the blocking door])[command clarification break]]
[!!!] closing doors before locking rule response (A) is "(first closing [the door ajar])[command clarification break]". [(first closing [the door ajar])[command clarification break]]
[!!!] closing doors before locking keylessly rule response (A) is "(first closing [the door ajar])[command clarification break]". [(first closing [the door ajar])[command clarification break]]
[!!!] unlocking before opening rule response (A) is "(first unlocking [the sealed chest])[command clarification break]". [(first unlocking [the sealed chest])[command clarification break]]
[!!!] standard printing key lack rule response (A) is "[We] [lack] a key that fits [the locked-thing].". [[We] [lack] a key that fits [the locked-thing].]
[!!!] right second rule response (A) is "[The second noun] [do not fit] [the noun].". [[The second noun] [do not fit] [the noun].]
[!!!] standard keylessly unlocking rule response (A) is "(with [the key unlocked with])[command clarification break]". [(with [the key unlocked with])[command clarification break]]
[!!!] standard keylessly locking rule response (A) is "(with [the key locked with])[command clarification break]". [(with [the key locked with])[command clarification break]]
[!!!] identify passkeys in inventory rule response (A) is " (which [open] [the list of things unbolted by the item])". [ (which [open] [the list of things unbolted by the item])]
[!!!] passkey description rule response (A) is "[The noun] [unlock] [the list of things unbolted by the noun].". [[The noun] [unlock] [the list of things unbolted by the noun].]
[!!!] limiting keychains rule response (A) is "[The noun] [are] not a key.". [[The noun] [are] not a key.]
[!!!] must have accessible the noun rule response (A) is "Without holding [the noun], [we] [can] do nothing.". [Without holding [the noun], [we] [can] do nothing.]
[!!!] must have accessible the second noun rule response (A) is "Without holding [the second noun], [we] [can] do nothing.". [Without holding [the second noun], [we] [can] do nothing.]
[!!!] lock debugging rule response (A) is "Unlocking [the item].". [Unlocking [the item].]
[!!!] report universal unlocking rule response (A) is "A loud stereophonic click assures you that everything in the game has been unlocked.". [A loud stereophonic click assures you that everything in the game has been unlocked.]
[!!!] 
Part 3-2 - The Final Question

Volume 4 - Command parsing

Part 4-1 - Pronouns and possessives in commands

Part 4-2 - Understand grammar

Part 4-3 - Command parser internals

Part 4-4 - Informese translation of commands


Toki Pona Language ends here.

---- DOCUMENTATION ----

Examples go in the documentation section.

Example: * Test 1 - example 

	*:"Test 1"
	
	A fruit is a kind of thing. A fruit translates into tokipona as kili.

	tomo suli is a room. In tomo suli are tu kili.
	In tomo suli is a ijo.
	A backdrop called nena weka is in tomo suli.
	In tomo suli is a supa and a poki. A ilo suno is on supa.
	The poki is openable and closed.
	A poki telo is in poki.
	
	jan Nasin is a person in tomo. jan Nasin carries ilo toki.

	Every turn:
		if the player carries tu kili:
			end the story finally.
			
	After taking inventory:
		try jan nasin taking inventory.
		
	

	[Tomo lili is sewi of Tomo Suli.]
	
	
	Test me with "go / take me / take kili / i / take ijo / i / take kili".

