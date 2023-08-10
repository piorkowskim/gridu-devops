#!/usr/bin/env python3.6

import requests, os, json
from datetime import datetime


# credentials & URLs
BASE_URL = "https://api.surveymonkey.com/v3"
ACCESS_TOKEN = "rrO-QkyQB7hoLX17Fl9GSKyrsbREBSjylicHjJ4l0QxyzMPLFlJnbCIweAovK97MhyPMn74zQBJZVBTQ0codqLQ-EiXov5CKELwTukPPmi4nMw.h20ZMM8U7Q.f8uPHb"

headers = {
    'Authorization': f'Bearer {ACCESS_TOKEN}',
    'Content-Type': 'application/json'
}
def create_survey(survey_title):
    url = f'{BASE_URL}/surveys'

    payload = {
        'title': survey_title
    }

    print(f'url: {url}')
    survey_resp = requests.post(url, headers=headers, json=payload)
    if survey_resp.status_code != 201:
        print(f'Failed to create survey. Error: {survey_resp.text}')
        return None

    survey_id = survey_resp.json()['id']
    print(f'Survey created with ID: {survey_id}')
    return survey_id


def create_collector(survey_id):
    url = f'{BASE_URL}/surveys/{survey_id}/collectors'
    payload = {
        'type': 'email',
        'name': 'survey recipient',
        'thank_you_message': 'Thank you for expressing your opinion on red pandas!'
    }

    collector_resp = requests.post(url, headers=headers, json=payload)

    if collector_resp.status_code != 201:
        print(f'Failed to create collector. Error: {collector_resp.text}')
        return None

    collector_id = collector_resp.json()['id']
    print(f'Collector added with ID: {collector_id}')
    return collector_id


def create_email(survey_id, collector_id):
    url = f'{BASE_URL}/surveys/{survey_id}/collectors/{collector_id}/messages'
    email_payload = {
        'type': 'invite',
        'subject': 'Express yourself about red pandas'
    }

    email_resp = requests.post(url, headers=headers, json=email_payload)
    if email_resp.status_code != 201:
        print(f'Failed to create email. Error {email_resp.text}')
        return None

    email_id = email_resp.json()['id']
    print(f'Email created with ID: {email_id}')
    return email_id

def send_email(survey_id, email_id, collector_id):
    url = f'{BASE_URL}/surveys/{survey_id}/collectors/{collector_id}/messages/{email_id}/send'

    send_resp = requests.post(url, headers=headers, json={})
    if send_resp.status_code != 200:
        print(f'Failed to send email. Error: {send_resp.text}')
        return None
def add_recipients(survey_id, collector_id, email_id, email_list):
    url = f'{BASE_URL}/surveys/{survey_id}/collectors/{collector_id}/messages/{email_id}/recipients/bulk'

    recipients_payload = {
        'contacts': [{'email': email} for email in email_list]
    }

    recipients_resp = requests.post(url, headers=headers, json=recipients_payload)
    if recipients_resp.status_code != 200:
        print(f'Failed to add recipients. Error: {recipients_resp.text}')

    return recipients_payload
def add_pages_questions(survey_id, pages):
    url = f'{BASE_URL}/surveys/{survey_id}/pages'

    # adding pages
    for title, questions in pages.items():
        p_pos = 1
        pages_payload = {
            'title': title,
            'position': p_pos
        }
        p_pos += 1
        pages_resp = requests.post(url, headers=headers, json=pages_payload)

        if pages_resp.status_code != 201:
            print(f'Failed to create page. Error: {pages_resp.text}')
            return None

        page_id = pages_resp.json()['id']

        # adding questions
        for question_id, question_desc in questions.items():
            q_pos = 1
            question_payload = {
                'headings': [{'heading': question_desc['Description']}],
                'family': 'single_choice', # types are single_choice, multiple_choice, matrix, open_ended etc etc
                'subtype': 'vertical',
                'position': q_pos,
                'answers': {'choices': [{'text': answer} for answer in question_desc['Answers']]}
            }
            q_pos += 1
            question_resp = requests.post(f'{url}/{page_id}/questions', headers=headers, json=question_payload)
            if question_resp.status_code != 201:
                print(f'Failed to add question. Error: {question_resp.text}')
                return None

def main():
    with open('questions.txt') as f:
        payload = json.load(f)
    survey_title = list(payload.keys())[0]
    pages = payload[survey_title]

    survey_id = create_survey(survey_title)
    if survey_id:
        print(f'Successfully created {survey_title} with an ID of {survey_id}.')
        add_pages_questions(survey_id, pages)
        collector_id = create_collector(survey_id)
        if collector_id:
            print(f'Successfully created a collector with ID {collector_id}.')
            email_id = create_email(survey_id, collector_id)
            if email_id:
                print(f'Successfully created an email with ID {email_id}.')
                with open('emails.txt') as f:
                    emails = f.read().splitlines()
                    add_recipients(survey_id, collector_id, email_id, emails)
                    send_email(survey_id, email_id, collector_id)

main()