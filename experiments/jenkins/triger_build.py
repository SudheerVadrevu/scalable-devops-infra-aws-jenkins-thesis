from jenkinsapi.jenkins import Jenkins
from jenkinsapi.utils.crumb_requester import CrumbRequester
from config import *


def get_server_instance():
    server = Jenkins(JENKINS_URL, username=JENKINS_USERNAME, password=JENKINS_PWD, 
    requester=CrumbRequester(
                       baseurl=JENKINS_URL,
                       username=JENKINS_USERNAME,
                       password=JENKINS_PWD
                  ))
    return server

def get_job_details():
    # Refer Example #1 for definition of function 'get_server_instance'
    server = get_server_instance()
    for j in server.get_jobs():
        job_instance = server.get_job(j[0])
        print(job_instance.__dict__)

"""Disable a Jenkins job"""
def disable_job(job_name):
    # Refer Example #1 for definition of function 'get_server_instance'
    server = get_server_instance()
    if (server.has_job(job_name)):
        job_instance = server.get_job(job_name)
        job_instance.disable()
        print('Name:%s,Is Job Enabled ?:%s' %(job_name,job_instance.is_enabled()))

def start_job(job_name, number_of_build):
    server = get_server_instance()
    if not (server.has_job(job_name)):
        print ("Job not found")
        return False
    job_instance = server.get_job(job_name)
    last_number = job_instance.get_last_buildnumber()
    for i in range(0, number_of_build):
        server.build_job(job_name)
        print("Build number {} start".format(last_number+i+1))
    print("All job started")
    return True


    
    

if __name__ == '__main__':
    get_job_details()
    start_job('Master Thesis Devops', 3)