import 'package:bmi_calculator/results_page.dart';
import 'package:bmi_calculator/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'card_items.dart';
import 'constants.dart';
import 'button_bottom.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender {
  Male,
  Female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleCardColor = inactiveCardColor;
  Color femaleCardColor = inactiveCardColor;

  int height = 175;
  int weight = 60;
  int age = 18;

  void _updateColor(Gender gender) {
    setState(() {
      if (gender == Gender.Male) {
        maleCardColor = maleCardColor == inactiveCardColor
            ? activeCardColor
            : inactiveCardColor;
        femaleCardColor = inactiveCardColor;
      } else if (gender == Gender.Female) {
        femaleCardColor = femaleCardColor == inactiveCardColor
            ? activeCardColor
            : inactiveCardColor;
        maleCardColor = inactiveCardColor;
      }
    });
  }

  void increaseWeight() {
    setState(() {
      weight++;
    });
  }

  void decreaseWeight() {
    setState(() {
      weight--;
    });
  }

  void increaseAge() {
    setState(() {
      age++;
    });
  }

  void decreaseAge() {
    setState(() {
      age--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => _updateColor(Gender.Male),
                    child: ReusableCard(
                      colour: maleCardColor,
                      cardChild: CardItems(
                        text: 'MALE',
                        icon: FontAwesomeIcons.mars,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _updateColor(Gender.Female),
                    child: ReusableCard(
                      colour: femaleCardColor,
                      cardChild: CardItems(
                        text: 'FEMALE',
                        icon: FontAwesomeIcons.venus,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: activeCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'HEIGHT',
                            style: textLabelStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              height.toString(),
                              style: numberStyle,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'CM',
                              style: textLabelStyle,
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Color(0XFF8D8E98),
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 15.0),
                            thumbColor: Color(0XFFEB1555),
                            overlayColor: Color(0x29EB1555),
                            overlayShape:
                                RoundSliderThumbShape(enabledThumbRadius: 20.0),
                          ),
                          child: Slider(
                            value: height.toDouble(),
                            min: 120.0,
                            max: 220.0,
                            onChanged: (double value) {
                              setState(() {
                                height = value.round();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: activeCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: textLabelStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: numberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: Icons.remove,
                              function: decreaseWeight,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: Icons.add,
                              function: increaseWeight,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: activeCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: textLabelStyle,
                        ),
                        Text(
                          age.toString(),
                          style: numberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: Icons.remove,
                              function: decreaseAge,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: Icons.add,
                              function: increaseAge,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ButtonBottom(
            text: 'CALCULATE',
            onPressed: () {
              CalculatorBrain calc =
                  CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    bmi: calc.getBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.function});

  final Function function;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: function,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
