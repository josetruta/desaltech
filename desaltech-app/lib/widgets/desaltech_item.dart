import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DesalTechItem extends StatelessWidget {
  const DesalTechItem({
    super.key, 
    required this.desaltechUid,
    required this.onSelectDesaltech
  });

  final String desaltechUid;
  final void Function() onSelectDesaltech;
  
  @override
  Widget build(BuildContext context) {

    final desaltechData = FirebaseFirestore.instance.collection('desaltechs').doc(desaltechUid).snapshots();

    return StreamBuilder(
      stream: desaltechData, 
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return Card(
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            elevation: 2,
            child: Container(
              width: double.infinity,
              height: 100,
              color: Theme.of(context).colorScheme.secondaryContainer,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Houve algum erro. Tente mais tarde.')
                ],
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Card(
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            elevation: 2,
            child: Container(
              width: double.infinity,
              height: 100,
              color: Theme.of(context).colorScheme.secondaryContainer,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator()
                ],
              ),
            ),
          );
        }

        final data = snapshot.data!.data()!;

        DateTime dt = (data['createdAt'] as Timestamp).toDate();
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final dateFormatted = formatter.format(dt);  

        return Card(
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          elevation: 2,
          child: InkWell(
          onTap: onSelectDesaltech,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                color: Theme.of(context).colorScheme.secondaryContainer,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(data['desaltech-name'],
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).colorScheme.onPrimaryContainer),
                        const SizedBox(width: 5),
                        Text(
                          dateFormatted,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.onPrimaryContainer),
                        const SizedBox(width: 5),
                        Text(
                          data['location'],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.water_drop,
                                color: Theme.of(context).colorScheme.onPrimaryContainer),
                              const SizedBox(width: 5),
                              Text(
                                '${data['vol-reservatorio']} L - Reservatório',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer
                                ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.water_drop_outlined,
                                color: Theme.of(context).colorScheme.onPrimaryContainer),
                              const SizedBox(width: 5),
                              Text(
                                '${data['vol-destilado']} L - Destilado',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
          ],
        ),
      ),
    );
      });
    
  }
}