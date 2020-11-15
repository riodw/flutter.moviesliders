// Pub
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
// - html
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/html_parser.dart';
// Project
import 'package:flutter_moviesliders/constants/globals.dart';

const htmlData = """
<div id="wbars_all">
  <div class="container base_container">
    <div id="wbars">
      <div class="content legal_pp">
        <div class="header">
          <h1>Privacy Policy of <strong>moviesliders.com</strong> and <strong>MovieSliders</strong> app</h1>
          <p>This Application collects some Personal Data from its Users.</p>
        </div>
        <!-- /header -->
        <div class="simple_pp">
          <div class="one_line_col">
            <h2 style="text-align: center; font-variant: small-caps">
              POLICY SUMMARY
            </h2>
          </div>
          <!-- /one_line_col -->
          <h2 id="purposes_data">
            Personal Data collected for the following purposes and using the
            following services:
          </h2>
          <ul class="for_boxes">
            <li>
                <h3>Analytics</h3>
                <ul class="unstyled">
                  <li>
                    <h3>Google Analytics for Firebase</h3>
                    <p>
                      Personal Data: Application opens; Application updates;
                      Cookies; device information; first launches;
                      geography/region; In-app purchases; number of
                      sessions; number of Users; operating systems; session
                      duration; unique device identifiers for advertising
                      (Google Advertiser ID or IDFA, for example); Usage
                      Data
                    </p>
                  </li>
                </ul>
            </li>
            <li>
                <h3>Beta Testing</h3>
                <ul class="unstyled">
                  <li>
                    <h3>App Center</h3>
                    <p>
                      Personal Data: Data communicated while using the
                      service; email address; various types of Data as
                      specified in the privacy policy of the service
                    </p>
                  </li>
                </ul>
            </li>
            <li>
              <div class="iconed policyicon_purpose_46">
                <h3>Platform services and hosting</h3>
                <ul class="unstyled">
                  <li>
                    <h3>Apple App Store</h3>
                    <p>Personal Data: Usage Data</p>
                  </li>
                </ul>
              </div>
            </li>
            <li>
              <div class="iconed policyicon_purpose_9">
                <h3>Registration and authentication</h3>
                <ul class="unstyled">
                  <li>
                    <h3>Firebase Authentication</h3>
                    <p>
                      Personal Data: email address; first name; last name;
                      profile picture; username
                    </p>
                  </li>
                </ul>
              </div>
            </li>
          </ul>
        </div>
        <!-- /simple_pp -->
        <div class="one_line_col">
          <h2 style="text-align: center; font-variant: small-caps">
            FULL POLICY
          </h2>
        </div>
        <!-- /one_line_col -->

        <div class="one_line_col">
          <h2 id="owner_of_the_data">Owner and Data Controller</h2>
        </div>

        <div class="one_line_col">
          <h2 id="types_of_data">Types of Data collected</h2>
          <p>
            Among the types of Personal Data that this Application collects, by
            itself or through third parties, there are: first name; last name;
            email address; profile picture; username; Usage Data; device
            information; number of Users; number of sessions; session duration;
            Application opens; Application updates; operating systems; Cookies;
            unique device identifiers for advertising (Google Advertiser ID or
            IDFA, for example); geography/region; In-app purchases; first
            launches; Data communicated while using the service.
          </p>
          <p>
            Complete details on each type of Personal Data collected are
            provided in the dedicated sections of this privacy policy or by
            specific explanation texts displayed prior to the Data
            collection.<br />Personal Data may be freely provided by the User,
            or, in case of Usage Data, collected automatically when using this
            Application.<br />Unless specified otherwise, all Data requested by
            this Application is mandatory and failure to provide this Data may
            make it impossible for this Application to provide its services. In
            cases where this Application specifically states that some Data is
            not mandatory, Users are free not to communicate this Data without
            consequences to the availability or the functioning of the
            Service.<br />Users who are uncertain about which Personal Data is
            mandatory are welcome to contact the Owner.<br />Any use of Cookies
            – or of other tracking tools – by this Application or by the owners
            of third-party services used by this Application serves the purpose
            of providing the Service required by the User, in addition to any
            other purposes described in the present document and in the Cookie
            Policy, if available.
          </p>
          <p>
            Users are responsible for any third-party Personal Data obtained,
            published or shared through this Application and confirm that they
            have the third party's consent to provide the Data to the Owner.
          </p>
        </div>
        <div class="one_line_col">
          <h2 id="place_of_processing">
            Mode and place of processing the Data
          </h2>
          <h3>Methods of processing</h3>
          <p>
            The Owner takes appropriate security measures to prevent
            unauthorized access, disclosure, modification, or unauthorized
            destruction of the Data.<br />The Data processing is carried out
            using computers and/or IT enabled tools, following organizational
            procedures and modes strictly related to the purposes indicated. In
            addition to the Owner, in some cases, the Data may be accessible to
            certain types of persons in charge, involved with the operation of
            this Application (administration, sales, marketing, legal, system
            administration) or external parties (such as third-party technical
            service providers, mail carriers, hosting providers, IT companies,
            communications agencies) appointed, if necessary, as Data Processors
            by the Owner. The updated list of these parties may be requested
            from the Owner at any time.
          </p>
          <h3>Legal basis of processing</h3>
          <p>
            The Owner may process Personal Data relating to Users if one of the
            following applies:
          </p>
          <ul>
            <li>
              Users have given their consent for one or more specific purposes.
              Note: Under some legislations the Owner may be allowed to process
              Personal Data until the User objects to such processing
              (“opt-out”), without having to rely on consent or any other of the
              following legal bases. This, however, does not apply, whenever the
              processing of Personal Data is subject to European data protection
              law;
            </li>
            <li>
              provision of Data is necessary for the performance of an agreement
              with the User and/or for any pre-contractual obligations thereof;
            </li>
            <li>
              processing is necessary for compliance with a legal obligation to
              which the Owner is subject;
            </li>
            <li>
              processing is related to a task that is carried out in the public
              interest or in the exercise of official authority vested in the
              Owner;
            </li>
            <li>
              processing is necessary for the purposes of the legitimate
              interests pursued by the Owner or by a third party.
            </li>
          </ul>
          <p>
            In any case, the Owner will gladly help to clarify the specific
            legal basis that applies to the processing, and in particular
            whether the provision of Personal Data is a statutory or contractual
            requirement, or a requirement necessary to enter into a contract.
          </p>
          <h3>Place</h3>
          <p>
            The Data is processed at the Owner's operating offices and in any
            other places where the parties involved in the processing are
            located.<br /><br />
            Depending on the User's location, data transfers may involve
            transferring the User's Data to a country other than their own. To
            find out more about the place of processing of such transferred
            Data, Users can check the section containing details about the
            processing of Personal Data.
          </p>
          <p>
            Users are also entitled to learn about the legal basis of Data
            transfers to a country outside the European Union or to any
            international organization governed by public international law or
            set up by two or more countries, such as the UN, and about the
            security measures taken by the Owner to safeguard their Data.<br /><br />
            If any such transfer takes place, Users can find out more by
            checking the relevant sections of this document or inquire with the
            Owner using the information provided in the contact section.
          </p>
          <h3>Retention time</h3>
          <p>
            Personal Data shall be processed and stored for as long as required
            by the purpose they have been collected for.
          </p>
          <p>Therefore:</p>
          <ul>
            <li>
              Personal Data collected for purposes related to the performance of
              a contract between the Owner and the User shall be retained until
              such contract has been fully performed.
            </li>
            <li>
              Personal Data collected for the purposes of the Owner’s legitimate
              interests shall be retained as long as needed to fulfill such
              purposes. Users may find specific information regarding the
              legitimate interests pursued by the Owner within the relevant
              sections of this document or by contacting the Owner.
            </li>
          </ul>
          <p>
            The Owner may be allowed to retain Personal Data for a longer period
            whenever the User has given consent to such processing, as long as
            such consent is not withdrawn. Furthermore, the Owner may be obliged
            to retain Personal Data for a longer period whenever required to do
            so for the performance of a legal obligation or upon order of an
            authority.<br /><br />
            Once the retention period expires, Personal Data shall be deleted.
            Therefore, the right to access, the right to erasure, the right to
            rectification and the right to data portability cannot be enforced
            after expiration of the retention period.
          </p>
        </div>
        <div class="one_line_col">
          <h2 id="use_collected_data">The purposes of processing</h2>
          <p>
            The Data concerning the User is collected to allow the Owner to
            provide its Service, comply with its legal obligations, respond to
            enforcement requests, protect its rights and interests (or those of
            its Users or third parties), detect any malicious or fraudulent
            activity, as well as the following: Registration and authentication,
            Platform services and hosting, Analytics and Beta Testing.
          </p>
          <p>
            For specific information about the Personal Data used for each
            purpose, the User may refer to the section “Detailed information on
            the processing of Personal Data”.
          </p>
        </div>
        <div class="one_line_col">
          <h2 id="data_processing_detailed_info">
            Detailed information on the processing of Personal Data
          </h2>
          <p>
            Personal Data is collected for the following purposes and using the
            following services:
          </p>
          <ul class="for_boxes">
            <li>
              <div class="box_primary box_10 expand">
                <h3 class="expand-click w_icon_24 policyicon_purpose_7621492">
                  Analytics
                </h3>
                <div class="expand-content">
                  <p>
                    The services contained in this section enable the Owner to
                    monitor and analyze web traffic and can be used to keep
                    track of User behavior.
                  </p>
                  <h4>Google Analytics for Firebase</h4>
                  <div class="wrap">
                    <p>
                      Google Analytics for Firebase or Firebase Analytics is an
                      analytics service provided by Google LLC or by Google
                      Ireland Limited, depending on the location this
                      Application is accessed from.<br />
                      <strong>
                        In order to understand Google's use of Data, consult
                        <a
                          href="https://www.google.com/policies/privacy/partners/"
                          target="_blank"
                          rel="noopener"
                        >
                          Google's partner policy
                        </a>
                      </strong>
                      .
                    </p>
                    <p>
                      Firebase Analytics may share Data with other tools
                      provided by Firebase, such as Crash Reporting,
                      Authentication, Remote Config or Notifications. The User
                      may check this privacy policy to find a detailed
                      explanation about the other tools used by the Owner.
                    </p>
                    <p>
                      This Application uses identifiers for mobile devices and
                      technologies similar to cookies to run the Firebase
                      Analytics service.
                    </p>
                    <p>
                      Users may opt-out of certain Firebase features through
                      applicable device settings, such as the device advertising
                      settings for mobile phones or by following the
                      instructions in other Firebase related sections of this
                      privacy policy, if available.
                    </p>
                  </div>
                  <p>
                    Personal Data processed: Application opens; Application
                    updates; Cookies; device information; first launches;
                    geography/region; In-app purchases; number of sessions;
                    number of Users; operating systems; session duration; unique
                    device identifiers for advertising (Google Advertiser ID or
                    IDFA, for example); Usage Data.
                  </p>
                  <p>
                    Place of processing: United States –
                    <a
                      href="https://policies.google.com/privacy"
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      Privacy Policy
                    </a>
                    ; Ireland –
                    <a
                      href="https://policies.google.com/privacy"
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      Privacy Policy
                    </a>
                    . Privacy Shield participant.
                  </p>
                </div>
              </div>
            </li>

            <li>
              <div class="box_primary box_10 expand">
                <h3 class="expand-click w_icon_24 policyicon_purpose_7621493">
                  Beta Testing
                </h3>
                <div class="expand-content">
                  <p>
                    This type of service makes it possible to manage User access
                    to this Application, or parts of it, for the purpose of
                    testing a certain feature or the entire Application.<br />
                    The service provider may automatically collect data related
                    to crashes and statistics related to the User's use of this
                    Application in a personally identifiable form.
                  </p>
                  <h4>App Center (Microsoft Corporation)</h4>
                  <div class="wrap">
                    <p>
                      App Center is a beta testing service provided by Microsoft
                      Corporation. This Application may also send push
                      notifications to the User.
                    </p>
                  </div>
                  <p>
                    Personal Data processed: Data communicated while using the
                    service; email address; various types of Data as specified
                    in the privacy policy of the service.
                  </p>
                  <p>
                    Place of processing: United States –
                    <a
                      href="https://privacy.microsoft.com/en-us/PrivacyStatement"
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      Privacy Policy
                    </a>
                    . Privacy Shield participant.
                  </p>
                </div>
              </div>
            </li>

            <li>
              <div class="box_primary box_10 expand">
                <h3 class="expand-click w_icon_24 policyicon_purpose_7621488">
                  Platform services and hosting
                </h3>
                <div class="expand-content">
                  <p>
                    These services have the purpose of hosting and running key
                    components of this Application, therefore allowing the
                    provision of this Application from within a unified
                    platform. Such platforms provide a wide range of tools to
                    the Owner – e.g. analytics, user registration, commenting,
                    database management, e-commerce, payment processing – that
                    imply the collection and handling of Personal Data. <br />
                    Some of these services work through geographically
                    distributed servers, making it difficult to determine the
                    actual location where the Personal Data are stored.
                  </p>
                  <h4>Apple App Store (Apple Inc.)</h4>
                  <div class="wrap">
                    <p>
                      This Application is distributed on Apple's App Store, a
                      platform for the distribution of mobile apps, provided by
                      Apple Inc.
                    </p>
                    <p>
                      By virtue of being distributed via this app store, Apple
                      collects basic analytics and provides reporting features
                      that enables the Owner to view usage analytics data and
                      measure the performance of this Application. Much of this
                      information is processed on an opt-in basis.
                    </p>
                    <p>
                      Users may opt-out of this analytics feature directly
                      through their device settings. More information on how to
                      manage analysis settings can be found on
                      <a
                        href="https://support.apple.com/en-us/HT202100"
                        target="_blank"
                        rel="noopener"
                      >
                        this page
                      </a>
                      .
                    </p>
                  </div>
                  <p>Personal Data processed: Usage Data.</p>
                  <p>
                    Place of processing: United States –
                    <a
                      href="https://www.apple.com/legal/privacy/"
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      Privacy Policy
                    </a>
                    . Privacy Shield participant.
                  </p>
                </div>
              </div>
            </li>
            <li>
              <div class="box_primary box_10 expand">
                <h3 class="expand-click w_icon_24 policyicon_purpose_7621487">
                  Registration and authentication
                </h3>
                <div class="expand-content">
                  <p>
                    By registering or authenticating, Users allow this
                    Application to identify them and give them access to
                    dedicated services.<br />
                    Depending on what is described below, third parties may
                    provide registration and authentication services. In this
                    case, this Application will be able to access some Data,
                    stored by these third-party services, for registration or
                    identification purposes. <br />
                    Some of the services listed below may also collect Personal
                    Data for targeting and profiling purposes; to find out more,
                    please refer to the description of each service.
                  </p>
                  <h4>Firebase Authentication</h4>
                  <div class="wrap">
                    <p>
                      Firebase Authentication is a registration and
                      authentication service provided by Google LLC or by Google
                      Ireland Limited, depending on the location this
                      Application is accessed from. To simplify the registration
                      and authentication process, Firebase Authentication can
                      make use of third-party identity providers and save the
                      information on its platform.
                    </p>
                  </div>
                  <p>
                    Personal Data processed: email address; first name; last
                    name; profile picture; username.
                  </p>
                  <p>
                    Place of processing: United States –
                    <a
                      href="https://policies.google.com/privacy"
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      Privacy Policy
                    </a>
                    ; Ireland –
                    <a
                      href="https://policies.google.com/privacy"
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      Privacy Policy
                    </a>
                    . Privacy Shield participant.
                  </p>
                </div>
              </div>
            </li>
          </ul>
        </div>
        <div class="one_line_col">
          <h2 id="rights_subjects">The rights of Users</h2>
          <p>
            Users may exercise certain rights regarding their Data processed by
            the Owner.
          </p>
          <p>In particular, Users have the right to do the following:</p>
          <ul>
            <li>
              <b> Withdraw their consent at any time. </b>
              Users have the right to withdraw consent where they have
              previously given their consent to the processing of their Personal
              Data.
            </li>
            <li>
              <b> Object to processing of their Data. </b>
              Users have the right to object to the processing of their Data if
              the processing is carried out on a legal basis other than consent.
              Further details are provided in the dedicated section below.
            </li>
            <li>
              <b> Access their Data. </b>
              Users have the right to learn if Data is being processed by the
              Owner, obtain disclosure regarding certain aspects of the
              processing and obtain a copy of the Data undergoing processing.
            </li>
            <li>
              <b> Verify and seek rectification. </b>
              Users have the right to verify the accuracy of their Data and ask
              for it to be updated or corrected.
            </li>
            <li>
              <b> Restrict the processing of their Data. </b>
              Users have the right, under certain circumstances, to restrict the
              processing of their Data. In this case, the Owner will not process
              their Data for any purpose other than storing it.
            </li>
            <li>
              <b> Have their Personal Data deleted or otherwise removed. </b>
              Users have the right, under certain circumstances, to obtain the
              erasure of their Data from the Owner.
            </li>
            <li>
              <b>
                Receive their Data and have it transferred to another
                controller.
              </b>
              Users have the right to receive their Data in a structured,
              commonly used and machine readable format and, if technically
              feasible, to have it transmitted to another controller without any
              hindrance. This provision is applicable provided that the Data is
              processed by automated means and that the processing is based on
              the User's consent, on a contract which the User is part of or on
              pre-contractual obligations thereof.
            </li>
            <li>
              <b> Lodge a complaint. </b>
              Users have the right to bring a claim before their competent data
              protection authority.
            </li>
          </ul>
          <h3>Details about the right to object to processing</h3>
          <p>
            Where Personal Data is processed for a public interest, in the
            exercise of an official authority vested in the Owner or for the
            purposes of the legitimate interests pursued by the Owner, Users may
            object to such processing by providing a ground related to their
            particular situation to justify the objection.
          </p>
          <p>
            Users must know that, however, should their Personal Data be
            processed for direct marketing purposes, they can object to that
            processing at any time without providing any justification. To
            learn, whether the Owner is processing Personal Data for direct
            marketing purposes, Users may refer to the relevant sections of this
            document.
          </p>
          <h3>How to exercise these rights</h3>
          <p>
            Any requests to exercise User rights can be directed to the Owner
            through the contact details provided in this document. These
            requests can be exercised free of charge and will be addressed by
            the Owner as early as possible and always within one month.
          </p>
        </div>
        <div class="one_line_col">
          <h2 id="further_data_processing_info">
            Additional information about Data collection and processing
          </h2>
          <h3>Legal action</h3>
          <p>
            The User's Personal Data may be used for legal purposes by the Owner
            in Court or in the stages leading to possible legal action arising
            from improper use of this Application or the related Services.<br />The
            User declares to be aware that the Owner may be required to reveal
            personal data upon request of public authorities.
          </p>
          <h3>Additional information about User's Personal Data</h3>
          <p>
            In addition to the information contained in this privacy policy,
            this Application may provide the User with additional and contextual
            information concerning particular Services or the collection and
            processing of Personal Data upon request.
          </p>
          <h3>System logs and maintenance</h3>
          <p>
            For operation and maintenance purposes, this Application and any
            third-party services may collect files that record interaction with
            this Application (System logs) use other Personal Data (such as the
            IP Address) for this purpose.
          </p>
          <h3>Information not contained in this policy</h3>
          <p>
            More details concerning the collection or processing of Personal
            Data may be requested from the Owner at any time. Please see the
            contact information at the beginning of this document.
          </p>
          <h3>How “Do Not Track” requests are handled</h3>
          <p>
            This Application does not support “Do Not Track” requests.<br />To
            determine whether any of the third-party services it uses honor the
            “Do Not Track” requests, please read their privacy policies.
          </p>
          <h3>Changes to this privacy policy</h3>
          <p>
            The Owner reserves the right to make changes to this privacy policy
            at any time by notifying its Users on this page and possibly within
            this Application and/or - as far as technically and legally feasible
            - sending a notice to Users via any contact information available to
            the Owner. It is strongly recommended to check this page often,
            referring to the date of the last modification listed at the bottom.
            <br /><br />
            Should the changes affect processing activities performed on the
            basis of the User’s consent, the Owner shall collect new consent
            from the User, where required.
          </p>
        </div>
        <div class="one_line_col">
          <div class="box_primary box_10 definitions expand">
            <h3
              id="definitions_and_legal_references"
              class="expand-click w_icon_24 icon_ribbon"
            >
              Definitions and legal references
            </h3>
            <div class="expand-content">
              <h4>Personal Data (or Data)</h4>
              <p>
                Any information that directly, indirectly, or in connection with
                other information — including a personal identification number —
                allows for the identification or identifiability of a natural
                person.
              </p>
              <h4>Usage Data</h4>
              <p>
                Information collected automatically through this Application (or
                third-party services employed in this Application), which can
                include: the IP addresses or domain names of the computers
                utilized by the Users who use this Application, the URI
                addresses (Uniform Resource Identifier), the time of the
                request, the method utilized to submit the request to the
                server, the size of the file received in response, the numerical
                code indicating the status of the server's answer (successful
                outcome, error, etc.), the country of origin, the features of
                the browser and the operating system utilized by the User, the
                various time details per visit (e.g., the time spent on each
                page within the Application) and the details about the path
                followed within the Application with special reference to the
                sequence of pages visited, and other parameters about the device
                operating system and/or the User's IT environment.
              </p>
              <h4>User</h4>
              <p>
                The individual using this Application who, unless otherwise
                specified, coincides with the Data Subject.
              </p>
              <h4>Data Subject</h4>
              <p>The natural person to whom the Personal Data refers.</p>
              <h4>Data Processor (or Data Supervisor)</h4>
              <p>
                The natural or legal person, public authority, agency or other
                body which processes Personal Data on behalf of the Controller,
                as described in this privacy policy.
              </p>
              <h4>Data Controller (or Owner)</h4>
              <p>
                The natural or legal person, public authority, agency or other
                body which, alone or jointly with others, determines the
                purposes and means of the processing of Personal Data, including
                the security measures concerning the operation and use of this
                Application. The Data Controller, unless otherwise specified, is
                the Owner of this Application.
              </p>
              <h4>This Application</h4>
              <p>
                The means by which the Personal Data of the User is collected
                and processed.
              </p>
              <h4>Service</h4>
              <p>
                The service provided by this Application as described in the
                relative terms (if available) and on this site/application.
              </p>
              <h4>European Union (or EU)</h4>
              <p>
                Unless otherwise specified, all references made within this
                document to the European Union include all current member states
                to the European Union and the European Economic Area.
              </p>
              <h4>Cookies</h4>
              <p>Small sets of data stored in the User's device.</p>
              
              <hr />

              <h4>Legal information</h4>
              <p>
                This privacy statement has been prepared based on provisions of
                multiple legislations, including Art. 13/14 of Regulation (EU)
                2016/679 (General Data Protection Regulation).
              </p>
              <p>
                This privacy policy relates solely to this Application, if not
                stated otherwise within this document.
              </p>
            </div>
          </div>
        </div>
        <div class="footer">
          <p>Latest update: October 24, 2020</p>
        </div>
        <!-- /footer -->
      </div>
      <!-- /content -->
    </div>
    <!-- /wbars -->
  </div>
  <!-- /container base_container -->
</div>

<hr />
""";

class PrivacyView extends StatefulWidget {
  PrivacyView({Key key}) : super(key: key);

  @override
  _PrivacyView createState() => _PrivacyView();
}

class _PrivacyView extends State<PrivacyView> {
  bool _deleting = false;

  @override
  Widget build(final BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final FirebaseUser userProvider = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: _deleting
            ? Column(children: <Widget>[
                const SizedBox(
                  height: 60,
                ),
                const Text('Deleting in progress...'),
                const SizedBox(
                  height: 35,
                ),
                const Center(
                  child: const CircularProgressIndicator(),
                )
              ])
            : Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      // scrollDirection: Axis.horizontal,
                      child: Column(
                        children: <Widget>[
                          // Center(
                          //   child: Text(
                          //     'Privacy Policy',
                          //     style: Theme.of(context).textTheme.headline1,
                          //   ),
                          // ),
                          Html(
                            data: htmlData,
                            style: {},
                            onLinkTap: (url) async {
                              // print("Opening $url");

                              if (await canLaunch(url))
                                await launch(url);
                              else
                                // can't launch url, there is some error
                                throw "Could not launch $url";
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                      height: 45.0,
                      minWidth: 320.0,
                      color: Colors.red,
                      child: const Text('Delete Account & All Data'),
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('Are you Sure?'),
                              content: const Text(
                                'Deleting your account is irreversible.',
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  textColor: Colors.red,
                                  child: const Text('DELETE EVEYTHING'),
                                  onPressed: () async {
                                    setState(() {
                                      _deleting = true;
                                      Navigator.pop(context);
                                    });

                                    // reference to reviews database
                                    final DatabaseReference _dbRef =
                                        dbRef.child('reviews');

                                    // REMOVE ALL FROM 'done'
                                    await _dbRef
                                        .child('done')
                                        .orderByChild('user_id')
                                        .equalTo(userProvider.uid)
                                        .once()
                                        .then(
                                      (final DataSnapshot snapshot) {
                                        snapshot.value?.forEach((key, value) {
                                          _dbRef
                                              .child('done')
                                              .child(key)
                                              .remove();
                                        });
                                      },
                                    );

                                    //// --- Can't run because access to /reviews/not_done is denied
                                    // REMOVE ALL FROM 'not_done'
                                    // await _dbRef
                                    //     .child('not_done')
                                    //     .orderByChild('user_id')
                                    //     .equalTo(userProvider.uid)
                                    //     .once()
                                    //     .then((final DataSnapshot snapshot) {
                                    //   snapshot.value?.forEach((key, value) {
                                    //     _dbRef
                                    //         .child('not_done')
                                    //         .child(key)
                                    //         .remove();
                                    //   });
                                    // });

                                    // DELETE USER
                                    try {
                                      await userProvider.delete();
                                      return 0;
                                    } on PlatformException catch (error) {
                                      print(error);
                                      await FirebaseAuth.instance.signOut();
                                      return error;
                                    }
                                  },
                                ),
                                FlatButton(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          )),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
      ),
    );
  }
}
