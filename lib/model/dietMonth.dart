class DietMonth {
  String condition;
  List<String> foodsToEat;
  List<String> foodsToAvoid;
  String lifeStyle;

  DietMonth(
      {required this.condition,
      required this.foodsToEat,
      required this.foodsToAvoid,
      required this.lifeStyle});
}

String winterCondition = 'Shishira / winter condition';
List<String> winterFoodsToEat = [
  'Foods having Amla as the predominant taste are preferred',
  'Cereals and pulses',
  'wheat/gram flour products',
  'rice',
  'corn',
  'Pippali (fruits of Piper longum)',
  'Haritaki (fruits of Terminalia chebula)'
];
List<String> winterFoodsToAvoid = [
  'Foods having Katu (pungent) , Tikta(bitter), Kashaya(astringent) predominant Rasa are to be avoided',
  'Laghu(light) and Shita(cold) foods are advised to be prohibited'
];
String winterLifestyle =
    'Massage with oil/powder/paste, bathing with lukewarm water, exposure to sunlight, wearing warm clothes are mentioned to follow. Vata aggravating lifestyle like exposure to cold wind, excessive walking, sleep at late night, are to be avoided.';
var winter = DietMonth(
    condition: winterCondition,
    foodsToEat: winterFoodsToEat,
    foodsToAvoid: winterFoodsToAvoid,
    lifeStyle: winterLifestyle);

String summerCondition = 'Grishma / summer condition';
List<String> summerFoodsToEat = [
  'Foods which are light to digest—those having Madhura (sweet),Snigdha (unctuous), Sheeta (cold), and Drava (liquid) Guna,such as rice, lentil, etc, are to be taken.',
  'taken. Drinking plenty of water and other liquids, such as cold water, buttermilk, fruit juices,meat soups, mango juice, churned curd with pepper, is to bepracticed.',
  'At bedtime milk with sugar candy is to be taken.'
];
List<String> summerFoodsToAvoid = [
  'Lavana and food with Katu (pungent) and Amla (sour) taste and Ushna (warm) foods are to be avoided.'
];
String summerLifestyle =
    'Staying in cool places, applying sandal wood and other aromatic pastes over the body, adorning with flowers, wearing light dresses and sleeping at day time are helpful. During night one can enjoy the cooled moonrays with breeze. Excessive exercise or hardwork is to be avoided; too much sexual indulgence and alcoholic preparations are prohibited.';
var summer = DietMonth(
    condition: summerCondition,
    foodsToEat: summerFoodsToEat,
    foodsToAvoid: summerFoodsToAvoid,
    lifeStyle: summerLifestyle);

String springCondition = 'Vasanta / spring condition';
List<String> springFoodsToEat = [
  'Among cereals, old barley, wheat, rice, and others are preferred.',
  'Among pulses, lentil, Mugda, and others, can be taken.',
  'Food items tasting Tikta (bitter), Katu (pungent), and Kashaya (astringent) are to be taken',
  'honey is to be included in the diet.'
];
List<String> springFoodsToAvoid = [
  'Food which are Sheeta (cold), Snigdha (viscous), Guru (heavy), Amla (sour), Madhura (sweet) are not preferred.',
];
String springLifestyle =
    'One should use warm water for bathing purpose, may do exercise during Vasant Ritu. Udvartana (massage) with powder of Chandana (Santalum album), Kesara (Crocus sativus), Agaru, and others, Kavala (gargle), Dhooma (smoking), Anjana (collyrium), and evacuative measures, such as Vamana and Nasya are advised. Day-sleep is strictly contraindicated during this season.';
var spring = DietMonth(
    condition: springCondition,
    foodsToEat: springFoodsToEat,
    foodsToAvoid: springFoodsToAvoid,
    lifeStyle: springLifestyle);

String autumnCondition = 'Sharat/autumn condition';
List<String> autumnFoodsToEat = [
  'Foods are having Madhura (sweet) and Tikta (bitter) taste, and of Laghu (light to digest) and cold properties are advised.',
  'Foods having the properties to pacify vitiated Pitta are advised.',
  'Wheat, green gram, sugar candy, honey, Patola (Trichosanthesdiocia), flesh of animals of dry land (Jangala Mamsa) are to beincluded in the diet.'
];
List<String> autumnFoodsToAvoid = [
  'Hot, bitter, sweet, and astringent foods are to be avoided. ',
  'The food items, such as fat, oils, meat of aquatic animals, curds, etc., are also to be not included in the diet during this season.'
];
String autumnLifestyle =
    'Habit of eating food, only when there is a feeling of hunger is recommended. One should take water purified by the rays of sun in day time and rays of moon at night time for drinking, bathing, etc. It is advised to wear flower garlands, and to apply paste of Chandana (Santalum album) on the body. It is said that moon rays in the first 3 h of night is conducive for health. Medical procedures, such as Virechana (purging), Rakta-Mokshana (blood letting), etc, should be done during this season. Day-sleep, excessive eating, excessive exposure to sunlight, etc.,are to be avoided.';
var autumn = DietMonth(
    condition: autumnCondition,
    foodsToEat: autumnFoodsToEat,
    foodsToAvoid: autumnFoodsToAvoid,
    lifeStyle: autumnLifestyle);

String monsoonCondition = 'Varsha / monsoon condition';
List<String> monsoonFoodsToEat = [
  'Foods having Amla (sour) and Lavana (salty) taste and of Sneha (unctuous) qualities are to be taken.',
  'Among cereals, old barley, rice, wheat, etc., are advised.',
  'Besides meat soup, Yusha (soup), etc. are to be included in the diet.',
  'one should take medicated water or boiled water.'
];
List<String> monsoonFoodsToAvoid = [
  'Intake of river water, churned preparations having more water, excessive liquid and wine are to be avoided.',
  'The foods, which are heavy and hard to digest, like meat, etc., are prohibited.'
];
String monsoonLifestyle =
    'Use of boiled water for bath and rubbing the body with oil properly after bath is advised. Medicated Basti (enema) is prescribed as an evacuative measure to expel vitiated Doshas. Getting wet in rain, day-sleep, exercise, hard work, sexual indulgence, wind, staying at river-bank, etc., are to be prohibited.';
var monsoon = DietMonth(
    condition: monsoonCondition,
    foodsToEat: monsoonFoodsToEat,
    foodsToAvoid: monsoonFoodsToAvoid,
    lifeStyle: monsoonLifestyle);

String lateAutumnCondition = 'Hemanta / Late Autumn condition';
List<String> lateAutumnFoodsToEat = [
  'One should use unctuous, sweet, sour, and salty foods. Among cereals and pulses, new rice, flour preparations, green gram, Masha, etc., are mentioned to be used.',
  'Various meats, fats, milk and milk products, sugarcane products, Shidhu (fermented preparations),Tila (sesame), and so on, are also to be included in the diet.'
];
List<String> lateAutumnFoodsToAvoid = [
  'Vata aggravating foods, such as Laghu (light), cold, and dry foods are to be avoided.',
  'Intake of colddrinks is also contraindicated.'
];
String lateAutumnLifestyle = 'Hemanta/ Late Autumn lifestyle';
var lateAutumn = DietMonth(
    condition: lateAutumnCondition,
    foodsToEat: lateAutumnFoodsToEat,
    foodsToAvoid: lateAutumnFoodsToAvoid,
    lifeStyle: lateAutumnLifestyle);
