import 'package:commet_chat/core/consts/colours.dart';
import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/fonts.dart';
import 'package:commet_chat/core/consts/list.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/features/registration/bloc/registration_bloc.dart';
import 'package:commet_chat/features/registration/pages/basic_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  TextEditingController educationField = TextEditingController();
  TextEditingController occupationField = TextEditingController();
  TextEditingController bussinessNameField = TextEditingController();
  TextEditingController cityField = TextEditingController();
  TextEditingController stateField = TextEditingController();
  TextEditingController countryField = TextEditingController();
  TextEditingController locationField = TextEditingController();
  TextEditingController annualField = TextEditingController();
  TextEditingController employedInField = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();

    showListPicker({
      required BuildContext context,
      required List<String> items,
      required TextEditingController controller,
    }) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  items[index],
                  style: const TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.pop(context);
                  controller.text = items[index];

                  // UPDATE FINAL LOCATION EVERY TIME
                  locationField.text =
                      "${cityField.text}${cityField.text.isNotEmpty ? ', ' : ''}"
                      "${stateField.text}${stateField.text.isNotEmpty ? ', ' : ''}"
                      "${countryField.text}";
                },
              );
            },
          );
        },
      );
    }

    void showLocationPicker(BuildContext context) {
      String? selectedCity;
      String? selectedState;
      String? selectedCountry;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: StatefulBuilder(
              builder: (context, setSheetState) {
                // CITY STEP
                if (selectedCity == null) {
                  return ListView(
                    children: cityList.map((city) {
                      return ListTile(
                        title: Text(city),
                        onTap: () {
                          setSheetState(() {
                            selectedCity = city;
                          });
                        },
                      );
                    }).toList(),
                  );
                }

                // STATE STEP
                if (selectedState == null) {
                  return ListView(
                    children: stateList.map((state) {
                      return ListTile(
                        title: Text(state),
                        onTap: () {
                          setSheetState(() {
                            selectedState = state;
                          });
                        },
                      );
                    }).toList(),
                  );
                }

                // COUNTRY STEP
                if (selectedCountry == null) {
                  return ListView(
                    children: countryList.map((country) {
                      return ListTile(
                        title: Text(country),
                        onTap: () {
                          selectedCountry = country;

                          Navigator.pop(context);

                          locationField.text =
                              "$selectedCity, $selectedState, $selectedCountry";
                        },
                      );
                    }).toList(),
                  );
                }

                return Container();
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              80.heightBox,
              Text(
                'Education and Career',
                style: TextStyle(fontSize: 24.sp, fontFamily: Fonts.bold),
              ),
              12.heightBox,
              Text(
                'Tell us about your qualification and what you do.',
                style: TextStyle(fontSize: 14.sp),
              ),
              12.heightBox,

              customTextField(
                validator: (value) => customTextValidator(value),
                label: "Highest Education",
                controller: educationField,
                onTap: () {
                  showListPicker(
                    context: context,
                    controller: educationField,
                    items: educationList,
                  );
                },
              ),
              16.heightBox,
              Text('Employed In', style: TextStyle(fontSize: 16.sp)),
              8.heightBox,
              BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  return Wrap(
                    children: List.generate(
                      employedInList.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 12, bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            bloc.add(
                              SelectEmployedInEvent(employedInList[index]),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 12.w,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  bloc.selecteEmploymentIn ==
                                      employedInList[index]
                                  ? AppColors.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color:
                                    bloc.selecteEmploymentIn ==
                                        employedInList[index]
                                    ? AppColors.primary
                                    : Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              employedInList[index],
                              style: TextStyle(
                                color:
                                    bloc.selecteEmploymentIn ==
                                        employedInList[index]
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              16.heightBox,
              customTextField(
                validator: (value) => customTextValidator(value),
                label: "Occupation",
                controller: occupationField,
                onTap: () {
                  showListPicker(
                    context: context,
                    controller: occupationField,
                    items: occupationList,
                  );
                },
              ),
              16.heightBox,
              customTextField(
                label: "Bussiness or Company Name",
                controller: bussinessNameField,
                validator: (value) => customTextValidator(value),
              ),
              16.heightBox,

              16.heightBox,
              customTextField(
                label: "Job Or Business Location",
                controller: locationField,
                readOnly: true,
                validator: (value) => customTextValidator(value),
                onTap: () {
                  showLocationPicker(context);
                },
              ),

              16.heightBox,
              customTextField(
                label: "Annual Income",
                controller: annualField,
                validator: (value) => customTextValidator(value),
              ),

              Spacer(),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          goRouter.pushNamed(Routes.basicDetailsScreen.name);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          elevation: WidgetStatePropertyAll(0),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                        child: Text(
                          'Previous',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: Fonts.regular,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    16.widthBox,
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            if (bloc.selecteEmploymentIn == null ||
                                bloc.selecteEmploymentIn!.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please select employment type",
                                  ),
                                ),
                              );
                              return;
                            }

                            goRouter.pushNamed(Routes.profilePhotoScreen.name);
                          }
                        },

                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColors.primary,
                          ),
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: Fonts.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              24.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
