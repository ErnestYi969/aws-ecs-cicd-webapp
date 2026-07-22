from flask import Flask, jsonify, request

app = Flask(__name__)

tasks = [
    {
        "id": 1,
        "title": "Learn AWS ECS",
        "completed": False
    }
]


@app.route("/")
def home():
    return "AWS ECS CI/CD Demo Application"


@app.route("/tasks", methods=["GET"])
def get_tasks():
    return jsonify(tasks)


@app.route("/tasks", methods=["POST"])
def create_task():
    data = request.json

    task = {
        "id": len(tasks) + 1,
        "title": data["title"],
        "completed": False
    }

    tasks.append(task)

    return jsonify(task), 201


@app.route("/tasks/<int:task_id>", methods=["DELETE"])
def delete_task(task_id):
    global tasks

    tasks = [
        task for task in tasks
        if task["id"] != task_id
    ]

    return jsonify({
        "message": "Task deleted"
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)