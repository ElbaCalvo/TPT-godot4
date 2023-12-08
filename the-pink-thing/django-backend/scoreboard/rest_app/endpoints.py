from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import Score
import json

# This should be kept private!
CLIENT_SECRET = 'abc'

@csrf_exempt
def score(request):
	if request.method == 'POST':
		body = json.loads(request.body)
		username = body.get('username', None)
		if username == None:
			return JsonResponse({'error': 'Missing username in request body'}, status=400)
		score = body.get('score', None)
		if score == None:
			return JsonResponse({'error': 'Missing score in request body'}, status=400)
		secret_client_key = request.headers.get("Client-Secret", None)
		if secret_client_key != CLIENT_SECRET:
			return JsonResponse({'error': 'Missing CLIENT_SECRET header'}, status=403)
		# Everything OK. Keep going
		new_score = Score(username=username, score=score)
		new_score.save()
		return JsonResponse({'created':'True'}, status=201)
	elif request.method == 'GET':
		scores = Score.objects.order_by("-score")
		response = []
		for s in scores:
			response.append({"username": s.username, "score": s.score})
		return JsonResponse(response, safe=False)
	else:
		return JsonResponse({'error':'Unsupported HTTP method'}, status=405)

