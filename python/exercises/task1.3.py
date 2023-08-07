import sys
from collections import Counter

def read_access_log(filename):
    user_agents = []

    try:
        with open(filename, 'r') as file:
            for line in file:
                # Assuming user agent appears between double quotes after ' " '
                start = line.find('"') + 1
                end = line.find('"', start + 1)
                user_agent = line[start:end]
                user_agents.append(user_agent)
    except FileNotFoundError:
        print("Error: File not found")
        sys.exit(1)

    return user_agents

def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <access_log_file>")
        sys.exit(1)

    filename = sys.argv[1]
    user_agents = read_access_log(filename)

    total_unique_user_agents = len(set(user_agents))
    print("Total different User Agents:", total_unique_user_agents)

    user_agent_counter = Counter(user_agents)
    print("\nUser Agent Statistics:")
    for user_agent, count in user_agent_counter.items():
        print(f"{user_agent}: {count} requests")

if __name__ == "__main__":
    main()
