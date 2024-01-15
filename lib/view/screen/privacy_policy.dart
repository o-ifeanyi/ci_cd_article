import 'package:checklist_app/core/util/config.dart';
import 'package:checklist_app/view/widget/constrained_box.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String route = '/privacy';
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBoxWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(left: Config.x(10)),
            child: Text(
              'Privacy Policy',
              style: Config.textTheme.titleMedium
                  ?.copyWith(color: theme.textTheme.bodyLarge?.color),
            ),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          padding: Config.contentPadding(h: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Config.vGap20,
              Text(
                '''
Onuoha Ifeanyi built the Checklist app as a Free app. This SERVICE is provided by Onuoha Ifeanyi at no cost and is intended for use as is.

This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.

If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Checklist unless otherwise defined in this Privacy Policy.
                ''',
                style: Config.textTheme.bodyMedium,
              ),
              Text(
                'Information Collection and Use',
                style: Config.textTheme.titleMedium,
              ),
              Text(
                '''
For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Email. The information that I request will be retained on your device and is not collected by me in any way.

The app does not use third-party services that may collect information used to identify you.

Link to the privacy policy of third-party service providers used by the app
                ''',
                style: Config.textTheme.bodyMedium,
              ),
              Text(
                'Cookies',
                style: Config.textTheme.titleMedium,
              ),
              Text(
                '''
Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly.

I may employ third-party companies and individuals due to the following reasons:

To facilitate our Service;
To provide the Service on our behalf;
To perform Service-related services; or
To assist us in analyzing how our Service is used.
I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.
                ''',
                style: Config.textTheme.bodyMedium,
              ),
              Text(
                'Security',
                style: Config.textTheme.titleMedium,
              ),
              Text(
                '''
I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.

Links to Other Sites

This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.
                ''',
                style: Config.textTheme.bodyMedium,
              ),
              Text(
                'Children\'s Privacy',
                style: Config.textTheme.titleMedium,
              ),
              Text(
                '''
These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.
                ''',
                style: Config.textTheme.bodyMedium,
              ),
              Text(
                'Changes to This Privacy Policy',
                style: Config.textTheme.titleMedium,
              ),
              Text(
                '''
I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

This policy is effective as of 2022-08-15
                ''',
                style: Config.textTheme.bodyMedium,
              ),
              Text(
                'Contact Us',
                style: Config.textTheme.titleMedium,
              ),
              Text(
                '''
If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at onuifeanyi95@gmail.com.
                ''',
                style: Config.textTheme.bodyMedium,
              ),
              Text(
                '''
This privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator
                ''',
                style: Config.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
