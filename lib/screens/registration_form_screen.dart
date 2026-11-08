import 'package:flutter/material.dart';

/// Experiment 7(a): Design a form with various input fields
class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String _ticketTier = 'Standard';
  bool _agreeToTerms = false;
  bool _receiveUpdates = true;
  int _ticketQuantity = 1;

  final List<String> _tiers = ['Student', 'Standard', 'VIP', 'Executive'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 7(a): Event Form Inputs'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Attendee Registration Form',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 1. Text Field: Full Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Enter attendee name',
                ),
              ),
              const SizedBox(height: 16),

              // 2. Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  hintText: 'name@example.com',
                ),
              ),
              const SizedBox(height: 16),

              // 3. Phone Number Field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  hintText: '+91 9876543210',
                ),
              ),
              const SizedBox(height: 16),

              // 4. Dropdown Field: Ticket Tier
              DropdownButtonFormField<String>(
                initialValue: _ticketTier,
                decoration: const InputDecoration(
                  labelText: 'Ticket Tier',
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
                items: _tiers.map((tier) {
                  return DropdownMenuItem(value: tier, child: Text(tier));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _ticketTier = val);
                },
              ),
              const SizedBox(height: 16),

              // 5. Quantity selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Number of Passes:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: _ticketQuantity > 1 ? () => setState(() => _ticketQuantity--) : null,
                        icon: const Icon(Icons.remove),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('$_ticketQuantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      IconButton.filledTonal(
                        onPressed: () => setState(() => _ticketQuantity++),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 6. Multiline Notes Field
              TextFormField(
                controller: _notesController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Special Dietary / Accessibility Notes',
                  prefixIcon: Icon(Icons.note),
                ),
              ),
              const SizedBox(height: 16),

              // 7. Checkboxes and Switches
              SwitchListTile(
                value: _receiveUpdates,
                title: const Text('Receive event updates via SMS/Email'),
                onChanged: (val) => setState(() => _receiveUpdates = val),
              ),
              CheckboxListTile(
                value: _agreeToTerms,
                title: const Text('I agree to the Eventify Terms & Conditions'),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (val) => setState(() => _agreeToTerms = val ?? false),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form inputs captured successfully')),
                    );
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Submit Form Inputs'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
